package tinode

import (
	"go-admin/app/controllers"
	"go-admin/app/models"

	"github.com/gin-gonic/gin"
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
	c.Success(ctx, gin.H{
		"list":  userList,
		"total": total,
	})
}
