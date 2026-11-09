package main

import (
	_ "go-admin/bootstrap"

	"go-admin/app/global/app/routes"
	"go-admin/app/utils/ginhelper"
)

func main() {
	engine := ginhelper.GetEngine()
	routes.InitRouter(engine)
	// 初始化插件路由
	ginhelper.InitPluginRoutes(engine)
	// 保存全局 Gin 引擎实例（供路由同步等功能在运行时遍历已注册路由使用）
	ginhelper.SetEngine(engine)
	// 启动服务器
	_ = ginhelper.StartServer(engine)
}
