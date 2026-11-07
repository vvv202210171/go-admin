package tokenhelper

import (
	"go-admin/app/global/app"
	"testing"
)

func TestGenerateToken(t *testing.T) {
	manager := &RedisTokenManager{}
	user := &app.ClaimsUser{UserID: 123}
	token, err := manager.GenerateToken(user)
	if err != nil {
		t.Errorf("GenerateToken failed: %v", err)
	}
	if token == "" {
		t.Error("GenerateToken returned empty token")
	}
	t.Logf("Generated token: %s", token)
}
