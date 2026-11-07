package app

import (
	"go.uber.org/zap"
	"gorm.io/gorm"
)

var (
	BasePath         string          // 定义项目的根目录
	ConfigYml        YmlConfigInterf // 全局配置文件指针
	GormDbMysql      *gorm.DB        // mysql数据库连接
	GormDbSqlserver  *gorm.DB        // sqlserver数据库连接
	GormDbPostgreSql *gorm.DB        // postgresql数据库连接
	ZapLog           *zap.Logger
	Cache            CacheInterf // 缓存指针

)
