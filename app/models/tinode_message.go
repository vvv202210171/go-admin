package models

import (
	"context"
	"encoding/json"
	"strings"
	"time"

	"go-admin/app/global/app"

	"gorm.io/gorm"
)

const (
	TinodeMsgText  = "text"
	TinodeMsgImage = "image"
	TinodeMsgAudio = "audio"
	TinodeMsgVideo = "video"
	TinodeMsgFile  = "file"
	TinodeMsgCall  = "call"

	TinodeTopicP2P = "p2p"
	TinodeTopicGrp = "grp"
	TinodeTopicSlf = "slf"
	TinodeTopicSys = "sys"
)

type TinodeMessage struct {
	ID         int             `gorm:"primaryKey;column:id" json:"-"`
	CreatedAt  time.Time       `gorm:"column:createdat" json:"-"`
	SeqID      int             `gorm:"column:seqid" json:"-"`
	Topic      string          `gorm:"column:topic" json:"-"`
	From       int64           `gorm:"column:from" json:"-"`
	Content    json.RawMessage `gorm:"column:content" json:"-"`
	UserTags   json.RawMessage `gorm:"column:user_tags" json:"-"`
	UserPublic json.RawMessage `gorm:"column:user_public" json:"-"`
}

func (TinodeMessage) TableName() string {
	return "messages"
}

func NewTinodeMessage() *TinodeMessage {
	return &TinodeMessage{}
}

type TinodeMessageList []*TinodeMessage

func NewTinodeMessageList() TinodeMessageList {
	return TinodeMessageList{}
}

func (list *TinodeMessageList) Find(c context.Context, funcs ...func(*gorm.DB) *gorm.DB) error {
	return app.DB().WithContext(c).Model(&TinodeMessage{}).
		Select("messages.id, messages.createdat, messages.seqid, messages.topic, messages.`from`, messages.content, users.tags AS user_tags, users.public AS user_public").
		Scopes(funcs...).
		Order("messages.createdat DESC, messages.id DESC").
		Find(list).Error
}

func (list *TinodeMessageList) GetTotal(c context.Context, funcs ...func(*gorm.DB) *gorm.DB) (int64, error) {
	var total int64
	err := app.DB().WithContext(c).Model(&TinodeMessage{}).Scopes(funcs...).Count(&total).Error
	return total, err
}

type TinodeMessageView struct {
	ID        int             `json:"id"`
	CreatedAt time.Time       `json:"createdAt"`
	Topic     string          `json:"topic"`
	SeqID     int             `json:"seqid"`
	From      int64           `json:"from,string"`
	Username  string          `json:"username"`
	MsgType   string          `json:"msgType"`
	TopicType string          `json:"topicType"`
	Content   string          `json:"content"`
	Public    json.RawMessage `json:"public"`
}

func (m *TinodeMessage) View() TinodeMessageView {
	return TinodeMessageView{
		ID:        m.ID,
		CreatedAt: m.CreatedAt,
		Topic:     strings.TrimSpace(m.Topic),
		SeqID:     m.SeqID,
		From:      m.From,
		Username:  usernameFromTags(m.UserTags),
		MsgType:   MessageType(m.Content),
		TopicType: TopicType(m.Topic),
		Content:   MessageText(m.Content),
		Public:    m.UserPublic,
	}
}

// TopicType 按会话名前缀区分消息所在的会话。grp 与 chn 都是群。
func TopicType(name string) string {
	name = strings.TrimSpace(name)
	if len(name) < 3 {
		return ""
	}
	switch name[:3] {
	case "p2p":
		return TinodeTopicP2P
	case "grp", "chn":
		return TinodeTopicGrp
	case "slf":
		return TinodeTopicSlf
	case "sys":
		return TinodeTopicSys
	default:
		return ""
	}
}

func usernameFromTags(raw json.RawMessage) string {
	var tags []string
	if err := json.Unmarshal(raw, &tags); err != nil {
		return ""
	}
	for _, tag := range tags {
		if strings.HasPrefix(tag, "basic:") {
			return strings.TrimPrefix(tag, "basic:")
		}
	}
	return ""
}

type draftyContent struct {
	Txt string        `json:"txt"`
	Ent []draftyEntry `json:"ent"`
}

type draftyEntry struct {
	Tp   string `json:"tp"`
	Data struct {
		Mime string `json:"mime"`
		Name string `json:"name"`
	} `json:"data"`
}

func parseDrafty(content json.RawMessage) (draftyContent, bool) {
	if len(content) == 0 || content[0] != '{' {
		return draftyContent{}, false
	}
	var doc draftyContent
	if err := json.Unmarshal(content, &doc); err != nil {
		return draftyContent{}, false
	}
	return doc, true
}

// MessageType 按附件类型归类。一条消息同时带文字和文件时，归到通话、视频、语音、图片、文件中优先级最高的一类。
func MessageType(content json.RawMessage) string {
	doc, ok := parseDrafty(content)
	if !ok {
		return TinodeMsgText
	}
	has := map[string]bool{}
	imageMime, audioMime, videoMime := false, false, false
	for _, ent := range doc.Ent {
		has[ent.Tp] = true
		mime := strings.ToLower(ent.Data.Mime)
		switch {
		case strings.HasPrefix(mime, "image/"):
			imageMime = true
		case strings.HasPrefix(mime, "audio/"):
			audioMime = true
		case strings.HasPrefix(mime, "video/"):
			videoMime = true
		}
	}
	switch {
	case has["VC"]:
		return TinodeMsgCall
	case has["VD"] || videoMime:
		return TinodeMsgVideo
	case has["AU"] || audioMime:
		return TinodeMsgAudio
	case has["IM"] || imageMime:
		return TinodeMsgImage
	case has["EX"]:
		return TinodeMsgFile
	default:
		return TinodeMsgText
	}
}

// MessageText 取出可阅读的正文。纯文本是 JSON 字符串，富文本取 txt。
func MessageText(content json.RawMessage) string {
	if len(content) == 0 || string(content) == "null" {
		return ""
	}
	var plain string
	if err := json.Unmarshal(content, &plain); err == nil {
		return plain
	}
	doc, ok := parseDrafty(content)
	if !ok {
		return ""
	}
	if text := strings.TrimSpace(doc.Txt); text != "" {
		return text
	}
	for _, ent := range doc.Ent {
		if name := strings.TrimSpace(ent.Data.Name); name != "" {
			return name
		}
	}
	return ""
}
