package tinode

import (
	"strings"

	"go-admin/app/controllers"
	"go-admin/app/models"

	"github.com/gin-gonic/gin"
)

type TinodeMessageController struct {
	controllers.Common
}

func NewTinodeMessageController() *TinodeMessageController {
	return &TinodeMessageController{}
}

func (c *TinodeMessageController) List(ctx *gin.Context) {
	var param models.TinodeMessageListParam
	if err := param.Validate(ctx); err != nil {
		c.FailAndAbort(ctx, err.Error(), err)
	}

	list := models.NewTinodeMessageList()
	total, err := list.GetTotal(ctx, param.Handle())
	if err != nil {
		c.FailAndAbort(ctx, err.Error(), err)
	}
	if err = list.Find(ctx, param.Paginate(), param.Handle()); err != nil {
		c.FailAndAbort(ctx, err.Error(), err)
	}

	views := make([]models.TinodeMessageView, 0, len(list))
	for _, item := range list {
		views = append(views, item.View())
	}
	c.Success(ctx, gin.H{
		"list":  views,
		"total": total,
	})
}

func (c *TinodeMessageController) TopicList(ctx *gin.Context) {
	var param models.TinodeTopicListParam
	if err := param.Validate(ctx); err != nil {
		c.FailAndAbort(ctx, err.Error(), err)
	}

	topics := models.NewTinodeTopicList()
	total, err := topics.GetTotal(ctx, param.Handle())
	if err != nil {
		c.FailAndAbort(ctx, err.Error(), err)
	}
	if err = topics.Find(ctx, param.Paginate(), param.Handle()); err != nil {
		c.FailAndAbort(ctx, err.Error(), err)
	}

	names := make([]string, 0, len(topics))
	for _, topic := range topics {
		names = append(names, topic.Name)
	}
	members, err := models.LoadTopicMembers(ctx, names)
	if err != nil {
		c.FailAndAbort(ctx, err.Error(), err)
	}

	previews, err := models.LoadTopicPreviews(ctx, names)
	if err != nil {
		c.FailAndAbort(ctx, err.Error(), err)
	}
	viewerID := strings.TrimSpace(param.UserID)

	views := make([]models.TinodeConversationView, 0, len(topics))
	for _, topic := range topics {
		name := strings.TrimSpace(topic.Name)
		views = append(views, topic.ViewFor(viewerID, members[name], previews[name]))
	}
	c.Success(ctx, gin.H{
		"list":  views,
		"total": total,
	})
}
