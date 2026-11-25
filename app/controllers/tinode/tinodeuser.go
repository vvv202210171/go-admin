package tinode

import (
	"time"

	"go-admin/app/controllers"
	"go-admin/app/global/app"
	"go-admin/app/models"

	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

type TinodeUserController struct {
	controllers.Common
}

func NewTinodeUserController() *TinodeUserController {
	return &TinodeUserController{}
}

func (c *TinodeUserController) List(ctx *gin.Context) {
	var param models.TinodeUserListParam
	if err := param.Validate(ctx); err != nil {
		c.FailAndAbort(ctx, err.Error(), err)
	}

	userList := models.NewTinodeUserList()
	total, err := userList.GetTotal(ctx, param.Handle())
	if err != nil {
		c.FailAndAbort(ctx, err.Error(), err)
	}
	err = userList.Find(ctx, param.Paginate(), param.Handle())
	if err != nil {
		c.FailAndAbort(ctx, err.Error(), err)
	}
	userList.FillAddress()
	c.Success(ctx, gin.H{
		"list":  userList,
		"total": total,
	})
}

// Summary 返回首页的总账户、当前在线人数，以及每日、每月新增注册。
// 总账户不计已删除用户。新增注册按 createdat 统计，包含后来被删除的账户。
// 在线人数向聊天服务查询，同一用户的多个连接只算一人。
func (c *TinodeUserController) Summary(ctx *gin.Context) {
	total, err := models.CountTinodeAccounts(ctx)
	if err != nil {
		c.FailAndAbort(ctx, "查询账户总数失败", err)
	}
	now := time.Now()
	daily, monthly, err := models.TinodeSignupReport(ctx, now)
	if err != nil {
		c.FailAndAbort(ctx, "查询新增注册失败", err)
	}
	peaks, err := models.TinodeOnlinePeaks(ctx, now)
	if err != nil {
		app.ZapLog.Warn("查询每日最高在线失败", zap.Error(err))
		peaks = []models.TinodeSignupPoint{}
	}

	var online any
	count, onlineErr := fetchPartnerOnline(ctx, partnerBaseURL(), partnerAPIKey())
	if onlineErr != nil {
		app.ZapLog.Warn("查询当前在线人数失败", zap.Error(onlineErr))
		online = nil
	} else {
		online = count
	}
	c.Success(ctx, gin.H{
		"accountTotal":     total,
		"onlineTotal":      online,
		"dailySignups":     daily,
		"monthlySignups":   monthly,
		"dailyOnlinePeaks": peaks,
	})
}
