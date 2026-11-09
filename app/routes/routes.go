package routes

import (
	"go-admin/app/controllers"
	"go-admin/app/middleware"

	"github.com/gin-gonic/gin"
)

var userControllers = controllers.NewUserController()     // 用户控制器
var authControllers = controllers.NewAuthController()     // 认证控制器
var configControllers = controllers.NewConfigController() // 配置控制器
func InitRouter(engine *gin.Engine) {
	setupGlobalMiddleware(engine)
	// 在这里定义路由
	api := engine.Group("/api")
	{
		// 公开路由
		public := api.Group("")
		public.POST("/login", middleware.CaptchaMiddleware(), authControllers.Login)
		// 获取验证码图片字符串
		public.GET("/captcha/verify", authControllers.GetVerifyImgString)
		public.GET("/config/get", configControllers.GetConfig)
		protected := api.Group("")
		protected.Use(middleware.AuthMiddleware())

		protected.Use(middleware.CasbinMiddleware())
		{
			users := protected.Group("/users")
			{
				users.GET("profile", userControllers.GetProfile) // 获取用户列表

			}

		}

		// protected.Use(middleware.DemoAccountMiddleware()) // 添加演示账号中间件
	}

}
