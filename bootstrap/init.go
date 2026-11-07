package bootstrap

import (
	"fmt"
	"go-admin/app/global/app"
	"go-admin/app/global/consts"
	"go-admin/app/service"
	"go-admin/app/utils/cachehelper"
	"go-admin/app/utils/gormhelper"
	"go-admin/app/utils/ymlconfig"
	"log"
	"os"
	"strings"
	"time"

	"go-admin/app/global/myerrors"

	"go.uber.org/zap"
	"go.uber.org/zap/zapcore"
	"gopkg.in/natefinch/lumberjack.v2"

	"gorm.io/gorm"
)

func init() {
	// 检查必要的文件夹是否存在，且加载配置文件
	checkRequiredFoldersAndConfig()
	// 加载版本信息
	if err := app.LoadVersionInfo(); err != nil {
		log.Println("加载版本信息失败", err)
	}
	// 日志
	app.ZapLog = createZapFactory(service.ZapLogHandler)
	// 初始化数据库
	initDB()
	//初始化缓存
	app.Cache = initCache()

}

// 初始化缓存
func initCache() app.CacheInterf {
	cacheType := app.ConfigYml.GetString("server.cachetype")
	switch cacheType {
	case "redis":
		//从配置中获取 Redis 的相关配置
		redisAddr := fmt.Sprintf("%s:%d", app.ConfigYml.GetString("redis.host"), app.ConfigYml.GetInt("redis.port"))
		redisPass := app.ConfigYml.GetString("redis.password")
		redisDB := app.ConfigYml.GetInt("redis.indexdb")
		// 初始化 Redis 缓存
		redisHelper, err := cachehelper.NewRedisCache(redisAddr, redisPass, redisDB)
		if err != nil {
			log.Fatal("初始化 Redis 缓存失败: " + err.Error())
		}
		log.Println("初始化 Redis 缓存成功")
		return redisHelper
	case "memory":
		// 初始化内存缓存
		memoryHelper := cachehelper.NewMemoryHelper()
		return memoryHelper
	default:
		// 默认使用内存缓存
		memoryHelper := cachehelper.NewMemoryHelper()
		return memoryHelper
	}
}

// 初始化数据库
func initDB() {
	// mysql
	if app.ConfigYml.GetInt("gormv2.mysql.isinitglobalgormmysql") == 1 {
		if dbMysql, err := gormhelper.GetOneMysqlClient(); err != nil {
			log.Fatal(myerrors.ErrorsGormInitFail + err.Error())
		} else {
			app.GormDbMysql = dbMysql
		}
	}
	//sqlserver
	if app.ConfigYml.GetInt("gormv2.sqlserver.isinitglobalgormsqlserver") == 1 {
		if dbSqlserver, err := gormhelper.GetOneSqlserverClient(); err != nil {
			log.Fatal(myerrors.ErrorsGormInitFail + err.Error())
		} else {
			app.GormDbSqlserver = dbSqlserver
		}
	}
	//postgresql
	if app.ConfigYml.GetInt("gormv2.postgresql.isinitglobalgormpostgresql") == 1 {
		if dbPostgresql, err := gormhelper.GetOnePostgreSqlClient(); err != nil {
			log.Fatal(myerrors.ErrorsGormInitFail + err.Error())
		} else {
			app.GormDbPostgreSql = dbPostgresql
		}
	}

	// 启动期校验 usedbtype 对应的连接确实已初始化。
	// 否则该类配置错误（如 usedbtype=mysql 但 isinitglobalgormmysql=0）会被推迟到
	// 首个请求调用 app.DB() 时才 log.Fatal，表现为"启动一切正常、一来请求进程即挂"
	usedbtype := app.ConfigYml.GetString("gormv2.usedbtype")
	var activeDB *gorm.DB
	var initSwitch string
	switch usedbtype {
	case consts.DbTypeMySql:
		activeDB, initSwitch = app.GormDbMysql, "gormv2.mysql.isinitglobalgormmysql"
	case consts.DbTypeSqlServer:
		activeDB, initSwitch = app.GormDbSqlserver, "gormv2.sqlserver.isinitglobalgormsqlserver"
	case consts.DbTypePostgreSql:
		activeDB, initSwitch = app.GormDbPostgreSql, "gormv2.postgresql.isinitglobalgormpostgresql"
	default:
		log.Fatalf("数据库配置错误：gormv2.usedbtype=%q 不是有效类型（mysql/sqlserver/postgresql），请检查 config.yml", usedbtype)
	}
	if activeDB == nil {
		log.Fatalf("数据库配置错误：gormv2.usedbtype=%s，但 %s 未开启，对应连接未初始化，请检查 config.yml", usedbtype, initSwitch)
	}
}

// createZapFactory 创建zap日志工厂
func createZapFactory(entry func(zapcore.Entry) error) *zap.Logger {
	// 获取程序所处的模式：  开发调试 、 生产
	appDebug := app.ConfigYml.GetBool("server.appdebug")

	// 判断程序当前所处的模式，调试模式直接返回一个便捷的zap日志管理器地址，所有的日志打印到控制台即可
	if appDebug == true {
		if logger, err := zap.NewDevelopment(zap.Hooks(entry)); err == nil {
			return logger
		} else {
			log.Fatal("创建zap日志包失败，详情：" + err.Error())
		}
	}

	// 以下才是 非调试（生产）模式所需要的代码
	encoderConfig := zap.NewProductionEncoderConfig()

	timePrecision := app.ConfigYml.GetString("logs.timeprecision")
	var recordTimeFormat string
	switch timePrecision {
	case "second":
		recordTimeFormat = "2006-01-02 15:04:05"
	case "millisecond":
		recordTimeFormat = "2006-01-02 15:04:05.000"
	default:
		recordTimeFormat = "2006-01-02 15:04:05"

	}
	encoderConfig.EncodeTime = func(t time.Time, enc zapcore.PrimitiveArrayEncoder) {
		enc.AppendString(t.Format(recordTimeFormat))
	}
	encoderConfig.EncodeLevel = zapcore.CapitalLevelEncoder
	encoderConfig.TimeKey = "created_at" // 生成json格式日志的时间键字段，默认为 ts,修改以后方便日志导入到 ELK 服务器

	var encoder zapcore.Encoder
	switch app.ConfigYml.GetString("logs.textformat") {
	case "console":
		encoder = zapcore.NewConsoleEncoder(encoderConfig) // 普通模式
	case "json":
		encoder = zapcore.NewJSONEncoder(encoderConfig) // json格式
	default:
		encoder = zapcore.NewConsoleEncoder(encoderConfig) // 普通模式
	}
	// 写入器
	fileName := app.BasePath + app.ConfigYml.GetString("logs.zaplogname")
	lumberJackLogger := &lumberjack.Logger{
		Filename:   fileName,                                //日志文件的位置
		MaxSize:    app.ConfigYml.GetInt("logs.maxsize"),    //在进行切割之前，日志文件的最大大小（以MB为单位）
		MaxBackups: app.ConfigYml.GetInt("logs.maxbackups"), //保留旧文件的最大个数
		MaxAge:     app.ConfigYml.GetInt("logs.maxage"),     //保留旧文件的最大天数
		Compress:   app.ConfigYml.GetBool("logs.compress"),  //是否压缩/归档旧文件
	}
	writer := zapcore.AddSync(lumberJackLogger)
	// 开始初始化zap日志核心参数，
	//参数一：编码器
	//参数二：写入器
	//参数三：参数级别，debug级别支持后续调用的所有函数写日志，如果是 fatal 高级别，则级别>=fatal 才可以写日志

	// 从配置文件读取日志等级
	logLevelStr := app.ConfigYml.GetString("logs.level")
	var logLevel zapcore.Level
	switch logLevelStr {
	case "debug":
		logLevel = zap.DebugLevel
	case "info":
		logLevel = zap.InfoLevel
	case "warn":
		logLevel = zap.WarnLevel
	case "error":
		logLevel = zap.ErrorLevel
	case "fatal":
		logLevel = zap.FatalLevel
	case "panic":
		logLevel = zap.PanicLevel
	default:
		logLevel = zap.InfoLevel // 默认使用 info 级别
	}

	zapCore := zapcore.NewCore(encoder, writer, logLevel)
	return zap.New(zapCore, zap.AddCaller(), zap.Hooks(entry), zap.AddStacktrace(zap.WarnLevel))
}

func checkRequiredFoldersAndConfig() {
	path, err := os.Getwd()
	if err != nil {
		log.Fatal("获取当前工作目录失败", err)
	}
	if len(os.Args) > 1 && strings.HasPrefix(os.Args[1], "-test") {
		app.BasePath = strings.Replace(strings.Replace(path, `\test`, "", 1), `/test`, "", 1)
	} else {
		app.BasePath = path
	}
	log.Println("当前项目根目录:", app.BasePath)

	// 检查配置文件是否存在
	if _, err := os.Stat(app.BasePath + consts.ConfigFilePath); os.IsNotExist(err) {
		log.Fatal("配置文件夹不存在")
	}
	app.ConfigYml = ymlconfig.CreateYamlFactory(app.BasePath + "/config")
}
