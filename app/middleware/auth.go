package middleware

import (
	"go-admin/app/global/app"
	"go-admin/app/global/consts"
	"go-admin/app/utils/common"
	"net/http"

	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

// AuthMiddleware JWT认证中间件
func AuthMiddleware() gin.HandlerFunc {
	return func(c *gin.Context) {
		tokenString, err := common.GetAccessTokenFromHeader(c)
		if err != nil {
			app.ZapLog.Error("Get access token failed", zap.Error(err))
			// 401 未认证
			app.Response.Fail(c, err.Error(), http.StatusUnauthorized)
			return
		}

		// 验证token
		claims, err := app.TokenManager.ValidateTokenWithCache(tokenString)
		if err != nil {
			app.ZapLog.Error("Invalid token", zap.Error(err))
			// 401 未认证
			app.Response.Fail(c, err.Error(), http.StatusUnauthorized)
			return
		}
		// 将用户信息存储到上下文中
		c.Set(consts.BindContextKeyName, claims)
		// 继续处理请求
		c.Next()
	}
}
