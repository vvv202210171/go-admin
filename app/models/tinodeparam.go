package models

import (
	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

type TinodeUserListParam struct {
	BasePaging
	Validator
	Id        uint     `form:"id"`
	Username  string   `form:"username"`
	Email     string   `form:"email"`
	State     string   `form:"state"`
	CreatedAt []string `form:"createdAt"`
}

func (r *TinodeUserListParam) Validate(c *gin.Context) error {
	return r.Check(c, r)
}
func (r *TinodeUserListParam) Handle() func(db *gorm.DB) *gorm.DB {
	return func(db *gorm.DB) *gorm.DB {
		if r.Id != 0 {
			db = db.Where("id = ?", r.Id)
		}

		if r.Username != "" {
			db = db.Where("JSON_CONTAINS(tags, JSON_QUOTE(?))", "basic:"+r.Username)
		}
		if r.Email != "" {
			db = db.Where("JSON_CONTAINS(tags, JSON_QUOTE(?))", "email:"+r.Email)
		}
		if r.State != "" {
			db = db.Where("state = ?", r.State)
		}
		if len(r.CreatedAt) >= 1 {
			if len(r.CreatedAt) == 1 {
				db = db.Where("createdat >= ?", r.CreatedAt[0])
			} else {
				db = db.Where("createdat BETWEEN ? AND ?", r.CreatedAt[0], r.CreatedAt[1])
			}
		}
		return db
	}
}
