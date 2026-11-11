package models

import (
	"strconv"
	"strings"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

type TinodeTopicListParam struct {
	BasePaging
	Validator
	Username string `form:"username"`
	UserID   string `form:"userId"`
}

func (r *TinodeTopicListParam) Validate(c *gin.Context) error {
	return r.Check(c, r)
}

func (r *TinodeTopicListParam) Handle() func(db *gorm.DB) *gorm.DB {
	return func(db *gorm.DB) *gorm.DB {
		db = db.Where("topics.state = ?", 0).
			Where("(topics.name LIKE 'p2p%' OR topics.name LIKE 'grp%' OR topics.name LIKE 'chn%')")
		if userID, ok := parseUserID(r.UserID); ok {
			db = db.Joins("JOIN subscriptions AS mine ON mine.topic = topics.name AND mine.userid = ? AND mine.deletedat IS NULL", userID)
		}
		if username := strings.TrimSpace(r.Username); username != "" {
			db = db.Where(`EXISTS (
				SELECT 1 FROM subscriptions AS s
				JOIN users AS u ON u.id = s.userid
				WHERE s.topic = topics.name AND s.deletedat IS NULL
				AND JSON_CONTAINS(u.tags, JSON_QUOTE(?))
			)`, "basic:"+username)
		}
		return db
	}
}

func parseUserID(value string) (int64, bool) {
	value = strings.TrimSpace(value)
	if value == "" {
		return 0, false
	}
	id, err := strconv.ParseInt(value, 10, 64)
	if err != nil || id == 0 {
		return 0, false
	}
	return id, true
}
