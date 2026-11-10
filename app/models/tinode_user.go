// 名	类型	长度	小数点	Not Null	虚拟	键	虚拟类型	表达式	Enum Value	默认值	注释	存储	列格式	Character Set	排序规则	键长度	永远生成	根据当前时间戳更新	二进制	自动递增	无符号	填充零
// id	bigint			true	false	true										0	false	false	false	false	false	false
// createdat	datetime	3		true	false	false											false	false	false	false	false	false
// updatedat	datetime	3		true	false	false											false	false	false	false	false	false
// state	smallint			true	false	false				0							false	false	false	false	false	false
// stateat	datetime	3		false	false	false				NULL							false	false	false	false	false	false
// access	json			false	false	false				NULL							false	false	false	false	false	false
// lastseen	datetime			false	false	false				NULL							false	false	false	false	false	false
// useragent	varchar	255		false	false	false				EMPTY STRING				utf8mb4	utf8mb4_0900_ai_ci		false	false	false	false	false	false
// public	json			false	false	false				NULL							false	false	false	false	false	false
// trusted	json			false	false	false				NULL							false	false	false	false	false	false
// tags	json			false	true	false				NULL							false	false	false	false	false	false
package models

import (
	"context"
	"encoding/json"
	"go-admin/app/global/app"
	"time"

	"gorm.io/gorm"
)

type TinodeUser struct {
	ID        uint            `gorm:"primaryKey" json:"ID,string"` // 雪花 ID 超出 JS 安全整数，按字符串返回
	CreatedAt time.Time       `gorm:"column:createdat"`
	UpdatedAt time.Time       `gorm:"column:updatedat"`
	State     int             `gorm:"column:state"`
	StateAt   time.Time       `gorm:"column:stateat"`
	Access    json.RawMessage `gorm:"column:access"`
	Lastseen  time.Time       `gorm:"column:lastseen"`
	Useragent string          `gorm:"column:useragent"`
	Public    json.RawMessage `gorm:"column:public"`
	Trusted   json.RawMessage `gorm:"column:trusted"`
	Tags      json.RawMessage `gorm:"column:tags"` // basic:用户名、email:邮箱
}
type TinodeUserListRequest struct {
	BasePaging
	Validator
	Name       string   `form:"name"`
	Phone      string   `form:"phone"`
	Status     string   `form:"status"`
	CreateTime []string `form:"createTime"`
}

func (TinodeUser) TableName() string {
	return "users"
}
func NewTinodeUser() *TinodeUser {
	return &TinodeUser{}
}

type TinodeUserList []*TinodeUser

func NewTinodeUserList() TinodeUserList {
	return TinodeUserList{}
}

func (list *TinodeUserList) Find(c context.Context, funcs ...func(*gorm.DB) *gorm.DB) error {
	return app.DB().WithContext(c).Scopes(funcs...).Find(list).Error
}

func (list *TinodeUserList) GetTotal(c context.Context, funcs ...func(*gorm.DB) *gorm.DB) (int64, error) {
	var total int64
	err := app.DB().WithContext(c).Scopes(funcs...).Model(TinodeUser{}).Count(&total).Error
	return total, err
}
