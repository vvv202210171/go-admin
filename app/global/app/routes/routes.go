package routes

import (
	"github.com/gin-gonic/gin"
)

func InitRouter(engine *gin.Engine) {
	setupGlobalMiddleware(engine)
	// 在这里定义路由
	engine.GET("/ping", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"message": "pong",
		})
	})
}
