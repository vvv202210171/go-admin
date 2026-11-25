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
	"encoding/base64"
	"encoding/binary"
	"encoding/json"
	"go-admin/app/global/app"
	"log"
	"strings"
	"sync"
	"time"

	"golang.org/x/crypto/xtea"
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
	// Address 是页面上的 usr 地址，由 users.id 算出，不落库
	Address string `gorm:"-" json:"Address"`
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

// 与聊天服务 ObjState 一致：20 表示已删除。总账户不计入已删除用户。
const tinodeStateDeleted = 20

// CountTinodeAccounts 统计未删除的聊天账户。
func CountTinodeAccounts(c context.Context) (int64, error) {
	var total int64
	err := app.DB().WithContext(c).Model(TinodeUser{}).Where("state <> ?", tinodeStateDeleted).Count(&total).Error
	return total, err
}

// TinodeSignupPoint 是一个时间桶里的新增注册人数。
type TinodeSignupPoint struct {
	Label string `json:"label"`
	Total int64  `json:"total"`
}

type tinodeSignupCount struct {
	Bucket string
	Total  int64
}

// TinodeSignupReport 统计近 30 天每天、近 12 个月每月的新增注册。没有注册的日期补 0。
func TinodeSignupReport(c context.Context, now time.Time) (daily []TinodeSignupPoint, monthly []TinodeSignupPoint, err error) {
	dayStart := time.Date(now.Year(), now.Month(), now.Day(), 0, 0, 0, 0, now.Location()).AddDate(0, 0, -29)
	monthStart := time.Date(now.Year(), now.Month(), 1, 0, 0, 0, 0, now.Location()).AddDate(0, -11, 0)
	dailyCounts, err := countTinodeSignups(c, dayStart, dayStart.AddDate(0, 0, 30), "%Y-%m-%d")
	if err != nil {
		return nil, nil, err
	}
	monthlyCounts, err := countTinodeSignups(c, monthStart, monthStart.AddDate(0, 12, 0), "%Y-%m")
	if err != nil {
		return nil, nil, err
	}
	return fillDailySignups(dayStart, dailyCounts), fillMonthlySignups(monthStart, monthlyCounts), nil
}

func countTinodeSignups(c context.Context, start, end time.Time, layout string) (map[string]int64, error) {
	var rows []tinodeSignupCount
	bucket := "DATE_FORMAT(createdat, '" + layout + "')"
	err := app.DB().WithContext(c).Model(TinodeUser{}).
		Select(bucket + " AS bucket, COUNT(*) AS total").
		Where("createdat >= ? AND createdat < ?", start, end).
		Group(bucket).
		Scan(&rows).Error
	if err != nil {
		return nil, err
	}
	counts := make(map[string]int64, len(rows))
	for _, row := range rows {
		counts[row.Bucket] = row.Total
	}
	return counts, nil
}

func fillDailySignups(start time.Time, counts map[string]int64) []TinodeSignupPoint {
	points := make([]TinodeSignupPoint, 0, 30)
	for i := 0; i < 30; i++ {
		label := start.AddDate(0, 0, i).Format("2006-01-02")
		points = append(points, TinodeSignupPoint{Label: label, Total: counts[label]})
	}
	return points
}

func fillMonthlySignups(start time.Time, counts map[string]int64) []TinodeSignupPoint {
	points := make([]TinodeSignupPoint, 0, 12)
	for i := 0; i < 12; i++ {
		label := start.AddDate(0, i, 0).Format("2006-01")
		points = append(points, TinodeSignupPoint{Label: label, Total: counts[label]})
	}
	return points
}

// FillAddress 用 users.id 算出每行的 usr 地址
func (list TinodeUserList) FillAddress() {
	for _, user := range list {
		if user == nil || user.ID == 0 {
			continue
		}
		user.Address = TinodeUserAddress(uint64(user.ID))
	}
}

// 和 xchat_chat/server/tinode.conf 的 store_config.uid_key 相同。
// 线上配置文件经常不随程序一起更新，缺 tinode.uidkey 时用这把密钥，避免地址变成空字符串。
const defaultTinodeUIDKey = "la6YsO+bNX/+XIkOqc5Svw=="

var (
	tinodeUIDMu     sync.Mutex
	tinodeUIDCipher *xtea.Cipher
)

// SetTinodeUIDKey 设置和聊天服务 store_config.uid_key 相同的 16 字节密钥。
func SetTinodeUIDKey(key []byte) error {
	cipher, err := xtea.NewCipher(key)
	if err != nil {
		return err
	}
	tinodeUIDMu.Lock()
	tinodeUIDCipher = cipher
	tinodeUIDMu.Unlock()
	return nil
}

func tinodeUIDKeyText() string {
	if app.ConfigYml == nil {
		return defaultTinodeUIDKey
	}
	raw := strings.TrimSpace(app.ConfigYml.GetString("tinode.uidkey"))
	if raw == "" {
		return defaultTinodeUIDKey
	}
	return raw
}

func tinodeUIDBlock() *xtea.Cipher {
	tinodeUIDMu.Lock()
	defer tinodeUIDMu.Unlock()
	if tinodeUIDCipher != nil {
		return tinodeUIDCipher
	}
	raw := tinodeUIDKeyText()
	key, err := base64.StdEncoding.DecodeString(raw)
	if err != nil || len(key) != 16 {
		log.Printf("tinode.uidkey 无效，用户地址无法计算")
		return nil
	}
	cipher, err := xtea.NewCipher(key)
	if err != nil {
		log.Printf("tinode.uidkey 无效，用户地址无法计算: %v", err)
		return nil
	}
	tinodeUIDCipher = cipher
	return tinodeUIDCipher
}

// TinodeUserAddress 把 users.id 编成网页上的 usr 地址。
// users.id 是解密后的主键，地址要对它做和聊天服务相同的 XTEA 加密后再编码。
func TinodeUserAddress(id uint64) string {
	cipher := tinodeUIDBlock()
	if id == 0 || cipher == nil {
		return ""
	}
	src := make([]byte, 8)
	dst := make([]byte, 8)
	binary.LittleEndian.PutUint64(src, id)
	cipher.Encrypt(dst, src)
	return "usr" + base64.RawURLEncoding.EncodeToString(dst)
}

// ParseTinodeUserAddress 把 usr 地址还原成 users.id。格式不对时返回 false。
func ParseTinodeUserAddress(address string) (uint64, bool) {
	cipher := tinodeUIDBlock()
	if cipher == nil {
		return 0, false
	}
	address = strings.TrimSpace(address)
	if !strings.HasPrefix(address, "usr") {
		return 0, false
	}
	body := address[3:]
	if len(body) != 11 {
		return 0, false
	}
	enc, err := base64.RawURLEncoding.DecodeString(body)
	if err != nil || len(enc) != 8 {
		return 0, false
	}
	plain := make([]byte, 8)
	cipher.Decrypt(plain, enc)
	id := binary.LittleEndian.Uint64(plain)
	if id == 0 {
		return 0, false
	}
	return id, true
}
