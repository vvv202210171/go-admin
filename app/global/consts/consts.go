package consts

// ContextKey 定义context key类型，避免使用内置string类型导致的冲突
type ContextKey string

const (
	BindContextKeyName = "userToken" // token解析值绑定上下文键名
	// 配置文件夹
	ConfigFilePath = "/config/config.yml" // 配置文件路径

	// 数据库类型
	DbTypeMySql      = "mysql"
	DbTypeSqlServer  = "sqlserver"
	DbTypePostgreSql = "postgresql"
)
