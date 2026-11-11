package models

import (
	"context"
	"encoding/json"
	"strconv"
	"strings"
	"time"

	"go-admin/app/global/app"

	"gorm.io/gorm"
)

type TinodeTopic struct {
	Name      string          `gorm:"column:name"`
	Public    json.RawMessage `gorm:"column:public"`
	TouchedAt *time.Time      `gorm:"column:touchedat"`
}

func (TinodeTopic) TableName() string {
	return "topics"
}

type TinodeTopicList []*TinodeTopic

func NewTinodeTopicList() TinodeTopicList {
	return TinodeTopicList{}
}

func (list *TinodeTopicList) Find(c context.Context, funcs ...func(*gorm.DB) *gorm.DB) error {
	return app.DB().WithContext(c).Model(&TinodeTopic{}).
		Select("topics.name, topics.public, topics.touchedat").
		Scopes(funcs...).
		Order("topics.touchedat DESC, topics.name ASC").
		Find(list).Error
}

func (list *TinodeTopicList) GetTotal(c context.Context, funcs ...func(*gorm.DB) *gorm.DB) (int64, error) {
	var total int64
	err := app.DB().WithContext(c).Model(&TinodeTopic{}).Scopes(funcs...).Count(&total).Error
	return total, err
}

type TinodeConversationUser struct {
	ID       string          `json:"id"`
	Username string          `json:"username"`
	Public   json.RawMessage `json:"public"`
}

type TinodeConversationView struct {
	Topic     string                   `json:"topic"`
	TopicType string                   `json:"topicType"`
	Name      string                   `json:"name"`
	Users     []TinodeConversationUser `json:"users"`
	Public    json.RawMessage          `json:"public"`
	Preview   string                   `json:"preview"`
	TouchedAt *time.Time               `json:"touchedAt"`
}

func (t *TinodeTopic) ViewFor(viewerID string, users []TinodeConversationUser, preview string) TinodeConversationView {
	if users == nil {
		users = []TinodeConversationUser{}
	}
	name, public := conversationFace(viewerID, t.Name, t.Public, users)
	return TinodeConversationView{
		Topic:     strings.TrimSpace(t.Name),
		TopicType: TopicType(t.Name),
		Name:      name,
		Users:     users,
		Public:    public,
		Preview:   preview,
		TouchedAt: t.TouchedAt,
	}
}

// conversationFace 从某个会员的视角取会话名称和头像。单聊取对方，群聊取群资料。
func conversationFace(viewerID, topic string, topicPublic json.RawMessage, users []TinodeConversationUser) (string, json.RawMessage) {
	viewerID = strings.TrimSpace(viewerID)
	if TopicType(topic) == TinodeTopicGrp {
		if name := publicName(topicPublic); name != "" {
			return name, topicPublic
		}
		return "群聊", topicPublic
	}
	for _, user := range users {
		if user.ID != "" && user.ID != viewerID {
			return displayUser(user), user.Public
		}
	}
	if len(users) > 0 {
		return displayUser(users[0]), users[0].Public
	}
	return strings.TrimSpace(topic), nil
}

func displayUser(user TinodeConversationUser) string {
	if name := publicName(user.Public); name != "" {
		return name
	}
	if name := strings.TrimSpace(user.Username); name != "" {
		return name
	}
	return user.ID
}

func publicName(raw json.RawMessage) string {
	if len(raw) == 0 || string(raw) == "null" {
		return ""
	}
	var public struct {
		Fn string `json:"fn"`
	}
	if err := json.Unmarshal(raw, &public); err != nil {
		return ""
	}
	return strings.TrimSpace(public.Fn)
}

type topicMemberRow struct {
	Topic  string          `gorm:"column:topic"`
	UserID int64           `gorm:"column:userid"`
	Tags   json.RawMessage `gorm:"column:tags"`
	Public json.RawMessage `gorm:"column:public"`
}

func LoadTopicMembers(c context.Context, topics []string) (map[string][]TinodeConversationUser, error) {
	grouped := make(map[string][]TinodeConversationUser, len(topics))
	if len(topics) == 0 {
		return grouped, nil
	}
	var rows []topicMemberRow
	err := app.DB().WithContext(c).
		Table("subscriptions AS s").
		Select("s.topic, s.userid, u.tags, u.public").
		Joins("JOIN users AS u ON u.id = s.userid").
		Where("s.deletedat IS NULL AND s.topic IN ?", topics).
		Order("s.topic ASC, s.userid ASC").
		Scan(&rows).Error
	if err != nil {
		return nil, err
	}
	for _, row := range rows {
		topic := strings.TrimSpace(row.Topic)
		grouped[topic] = append(grouped[topic], TinodeConversationUser{
			ID:       strconv.FormatInt(row.UserID, 10),
			Username: usernameFromTags(row.Tags),
			Public:   row.Public,
		})
	}
	return grouped, nil
}

func LoadTopicPreviews(c context.Context, topics []string) (map[string]string, error) {
	previews := make(map[string]string, len(topics))
	if len(topics) == 0 {
		return previews, nil
	}
	var rows []struct {
		Topic   string          `gorm:"column:topic"`
		Content json.RawMessage `gorm:"column:content"`
	}
	err := app.DB().WithContext(c).Raw(`
		SELECT m.topic, m.content
		FROM messages AS m
		JOIN (
			SELECT topic, MAX(seqid) AS seqid
			FROM messages
			WHERE topic IN ?
			GROUP BY topic
		) AS latest ON latest.topic = m.topic AND latest.seqid = m.seqid
	`, topics).Scan(&rows).Error
	if err != nil {
		return nil, err
	}
	for _, row := range rows {
		previews[strings.TrimSpace(row.Topic)] = MessageText(row.Content)
	}
	return previews, nil
}
