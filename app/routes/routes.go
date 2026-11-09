package routes

import (
	"go-admin/app/controllers"
	"go-admin/app/middleware"

	"github.com/gin-gonic/gin"
)

var authControllers = controllers.NewAuthController() // 认证控制器
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
	}

}
