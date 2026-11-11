package models

import (
	"strings"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

type TinodeMessageListParam struct {
	BasePaging
	Validator
	Username  string   `form:"username"`
	Content   string   `form:"content"`
	MsgType   string   `form:"msgType"`
	TopicType string   `form:"topicType"`
	Topic     string   `form:"topic"`
	CreatedAt []string `form:"createdAt"`
}

func (r *TinodeMessageListParam) Validate(c *gin.Context) error {
	return r.Check(c, r)
}

func (r *TinodeMessageListParam) Handle() func(db *gorm.DB) *gorm.DB {
	return func(db *gorm.DB) *gorm.DB {
		db = db.Joins("LEFT JOIN users ON users.id = messages.`from`")
		if username := strings.TrimSpace(r.Username); username != "" {
			db = db.Where("JSON_CONTAINS(users.tags, JSON_QUOTE(?))", "basic:"+username)
		}
		if content := strings.TrimSpace(r.Content); content != "" {
			db = db.Where("CAST(messages.content AS CHAR) LIKE ? ESCAPE '\\\\'", "%"+escapeLike(content)+"%")
		}
		if clause := messageTypeWhere(strings.TrimSpace(r.MsgType)); clause != "" {
			db = db.Where(clause)
		}
		if clause := topicTypeWhere(strings.TrimSpace(r.TopicType)); clause != "" {
			db = db.Where(clause)
		}
		if topic := strings.TrimSpace(r.Topic); topic != "" {
			db = db.Where("messages.topic = ?", topic)
		}
		if len(r.CreatedAt) >= 1 && strings.TrimSpace(r.CreatedAt[0]) != "" {
			if len(r.CreatedAt) == 1 || strings.TrimSpace(r.CreatedAt[1]) == "" {
				db = db.Where("messages.createdat >= ?", r.CreatedAt[0])
			} else {
				db = db.Where("messages.createdat BETWEEN ? AND ?", r.CreatedAt[0], r.CreatedAt[1])
			}
		}
		return db
	}
}

func topicTypeWhere(topicType string) string {
	switch topicType {
	case TinodeTopicP2P:
		return "messages.topic LIKE 'p2p%'"
	case TinodeTopicGrp:
		return "(messages.topic LIKE 'grp%' OR messages.topic LIKE 'chn%')"
	case TinodeTopicSlf:
		return "messages.topic LIKE 'slf%'"
	case TinodeTopicSys:
		return "messages.topic LIKE 'sys%'"
	default:
		return ""
	}
}

func escapeLike(value string) string {
	return strings.NewReplacer(`\`, `\\`, `%`, `\%`, `_`, `\_`).Replace(value)
}

func messageTypeWhere(msgType string) string {
	const (
		noCall  = "JSON_SEARCH(messages.content, 'one', 'VC', NULL, '$.ent[*].tp') IS NULL"
		noVideo = "JSON_SEARCH(messages.content, 'one', 'VD', NULL, '$.ent[*].tp') IS NULL AND JSON_SEARCH(messages.content, 'one', 'video/%', NULL, '$.ent[*].data.mime') IS NULL"
		noAudio = "JSON_SEARCH(messages.content, 'one', 'AU', NULL, '$.ent[*].tp') IS NULL AND JSON_SEARCH(messages.content, 'one', 'audio/%', NULL, '$.ent[*].data.mime') IS NULL"
		noImage = "JSON_SEARCH(messages.content, 'one', 'IM', NULL, '$.ent[*].tp') IS NULL AND JSON_SEARCH(messages.content, 'one', 'image/%', NULL, '$.ent[*].data.mime') IS NULL"
		noFile  = "JSON_SEARCH(messages.content, 'one', 'EX', NULL, '$.ent[*].tp') IS NULL"
	)
	switch msgType {
	case TinodeMsgText:
		return "messages.content IS NULL OR JSON_TYPE(messages.content) <> 'OBJECT' OR (" + noCall + " AND " + noVideo + " AND " + noAudio + " AND " + noImage + " AND " + noFile + ")"
	case TinodeMsgCall:
		return "JSON_SEARCH(messages.content, 'one', 'VC', NULL, '$.ent[*].tp') IS NOT NULL"
	case TinodeMsgVideo:
		return noCall + " AND (JSON_SEARCH(messages.content, 'one', 'VD', NULL, '$.ent[*].tp') IS NOT NULL OR JSON_SEARCH(messages.content, 'one', 'video/%', NULL, '$.ent[*].data.mime') IS NOT NULL)"
	case TinodeMsgAudio:
		return noCall + " AND " + noVideo + " AND (JSON_SEARCH(messages.content, 'one', 'AU', NULL, '$.ent[*].tp') IS NOT NULL OR JSON_SEARCH(messages.content, 'one', 'audio/%', NULL, '$.ent[*].data.mime') IS NOT NULL)"
	case TinodeMsgImage:
		return noCall + " AND " + noVideo + " AND " + noAudio + " AND (JSON_SEARCH(messages.content, 'one', 'IM', NULL, '$.ent[*].tp') IS NOT NULL OR JSON_SEARCH(messages.content, 'one', 'image/%', NULL, '$.ent[*].data.mime') IS NOT NULL)"
	case TinodeMsgFile:
		return noCall + " AND " + noVideo + " AND " + noAudio + " AND " + noImage + " AND JSON_SEARCH(messages.content, 'one', 'EX', NULL, '$.ent[*].tp') IS NOT NULL"
	default:
		return ""
	}
}
