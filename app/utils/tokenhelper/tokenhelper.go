package tokenhelper

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"go-admin/app/global/app"
	"go-admin/app/utils/jsonhelper"
	"time"

	"github.com/google/uuid"
)

// RedisTokenManager 基于 Redis 的不透明 Token 管理器（无 JWT）
// Access Token 与 Refresh Token 均为随机 UUID，Claims 序列化后存储在 Redis 中
type RedisTokenManager struct {
	Ctx            context.Context
	RedisHelper    app.CacheInterf
	TokenExpire    time.Duration
	RefreshExpire  time.Duration
	CacheKeyPrefix string
	IsCache        bool
}

// refreshPayload 是 Refresh Token 在 Redis 中的存储结构，
// 在 RefreshTokenClaims 之上附加 ExpiresAt 以支持 RotateRefreshToken 保留剩余 TTL
type refreshPayload struct {
	app.RefreshTokenClaims
	ExpiresAt time.Time `json:"expiresAt"`
}

func (r *RedisTokenManager) accessKey(token string) string {
	return fmt.Sprintf("%saccess:%s", r.CacheKeyPrefix, token)
}

func (r *RedisTokenManager) refreshKey(token string) string {
	return fmt.Sprintf("%srefresh:%s", r.CacheKeyPrefix, token)
}

func (r *RedisTokenManager) refreshUserKey(userID uint) string {
	return fmt.Sprintf("%srefresh:user:%d", r.CacheKeyPrefix, userID)
}

// GenerateToken 生成随机不透明 Access Token（不写 Redis）
func (r *RedisTokenManager) GenerateToken(user *app.ClaimsUser) (string, error) {
	return uuid.NewString(), nil
}

// ParseToken 从 Redis 解析 Access Token 对应的 Claims
func (r *RedisTokenManager) ParseToken(tokenString string) (*app.Claims, error) {
	raw, err := r.RedisHelper.Get(r.Ctx, r.accessKey(tokenString))
	if errors.Is(err, app.ErrKeyNotFound) {
		return nil, errors.New("token not found or expired")
	}
	if err != nil {
		return nil, err
	}
	var claims app.Claims
	if err = json.Unmarshal([]byte(raw), &claims); err != nil {
		return nil, fmt.Errorf("malformed token payload: %w", err)
	}
	if claims.TokenType != app.TokenTypeAccess {
		return nil, errors.New("invalid token type")
	}
	return &claims, nil
}

// ValidateToken 验证 Access Token（存在于 Redis 中即有效）
func (r *RedisTokenManager) ValidateToken(tokenString string) (*app.Claims, error) {
	return r.ParseToken(tokenString)
}

// GenerateTokenWithCache 生成 Access Token 并写入 Redis
func (r *RedisTokenManager) GenerateTokenWithCache(user *app.ClaimsUser) (string, error) {
	token, err := r.GenerateToken(user)
	if err != nil {
		return "", err
	}
	claims := app.Claims{ClaimsUser: *user, TokenType: app.TokenTypeAccess}
	payload := jsonhelper.Struct2Json(claims)

	if err = r.RedisHelper.Set(r.Ctx, r.accessKey(token), payload, r.TokenExpire); err != nil {
		return "", err
	}
	return token, nil
}

// ValidateTokenWithCache 验证 Access Token（从 Redis 校验）
func (r *RedisTokenManager) ValidateTokenWithCache(tokenString string) (*app.Claims, error) {
	return r.ParseToken(tokenString)
}

// RevokeTokenWithCache 撤销 Access Token（从 Redis 删除）
func (r *RedisTokenManager) RevokeTokenWithCache(tokenString string) error {
	return r.RedisHelper.Del(r.Ctx, r.accessKey(tokenString))
}

// GenerateRefreshToken 生成 Refresh Token 并写入 Redis，同时建立 userID → token 索引
func (r *RedisTokenManager) GenerateRefreshToken(userID uint, tenantID uint, tenantCode string) (string, error) {
	return r.generateRefreshTokenWithTTL(userID, tenantID, tenantCode, r.RefreshExpire)
}

func (r *RedisTokenManager) generateRefreshTokenWithTTL(userID uint, tenantID uint, tenantCode string, ttl time.Duration) (string, error) {
	token := uuid.NewString()
	p := refreshPayload{
		RefreshTokenClaims: app.RefreshTokenClaims{
			UserID:     userID,
			TenantID:   tenantID,
			TenantCode: tenantCode,
			TokenType:  app.TokenTypeRefresh,
		},
		ExpiresAt: time.Now().Add(ttl),
	}
	payload, err := json.Marshal(p)
	if err != nil {
		return "", err
	}
	if err = r.RedisHelper.Set(r.Ctx, r.refreshKey(token), string(payload), ttl); err != nil {
		return "", err
	}
	// userID → token 索引，供 RevokeRefreshToken 按用户撤销
	if err = r.RedisHelper.Set(r.Ctx, r.refreshUserKey(userID), token, ttl); err != nil {
		return "", err
	}
	return token, nil
}

// parseRefreshPayload 从 Redis 读取 Refresh Token 的完整存储结构
func (r *RedisTokenManager) parseRefreshPayload(tokenString string) (*refreshPayload, error) {
	raw, err := r.RedisHelper.Get(r.Ctx, r.refreshKey(tokenString))
	if errors.Is(err, app.ErrKeyNotFound) {
		return nil, errors.New("refresh token not found or expired")
	}
	if err != nil {
		return nil, err
	}
	var p refreshPayload
	if err = json.Unmarshal([]byte(raw), &p); err != nil {
		return nil, fmt.Errorf("malformed refresh token payload: %w", err)
	}
	if p.TokenType != app.TokenTypeRefresh {
		return nil, errors.New("invalid token type")
	}
	return &p, nil
}

// ParseRefreshToken 解析 Refresh Token
func (r *RedisTokenManager) ParseRefreshToken(tokenString string) (*app.RefreshTokenClaims, error) {
	p, err := r.parseRefreshPayload(tokenString)
	if err != nil {
		return nil, err
	}
	return &p.RefreshTokenClaims, nil
}

// ValidateRefreshToken 验证 Refresh Token（存在即有效）
func (r *RedisTokenManager) ValidateRefreshToken(tokenString string) (*app.RefreshTokenClaims, error) {
	return r.ParseRefreshToken(tokenString)
}

// RevokeRefreshToken 通过 userID 撤销其当前 Refresh Token
func (r *RedisTokenManager) RevokeRefreshToken(userID uint) error {
	token, err := r.RedisHelper.Get(r.Ctx, r.refreshUserKey(userID))
	if errors.Is(err, app.ErrKeyNotFound) {
		return nil // 已不存在，视为成功
	}
	if err != nil {
		return err
	}
	return r.RedisHelper.Del(r.Ctx, r.refreshKey(token), r.refreshUserKey(userID))
}

// RefreshAccessTokenWithCache 用合法的 Refresh Token 换发新 Access Token
func (r *RedisTokenManager) RefreshAccessTokenWithCache(refreshTokenString string, user *app.ClaimsUser) (string, error) {
	if _, err := r.ValidateRefreshToken(refreshTokenString); err != nil {
		return "", fmt.Errorf("refresh token invalid: %w", err)
	}
	return r.GenerateTokenWithCache(user)
}

// RotateRefreshToken 轮换 Refresh Token：撤销旧 token，签发保留相同剩余 TTL 的新 token
func (r *RedisTokenManager) RotateRefreshToken(oldRefreshToken string) (string, error) {
	p, err := r.parseRefreshPayload(oldRefreshToken)
	if err != nil {
		return "", fmt.Errorf("cannot rotate: %w", err)
	}
	remaining := time.Until(p.ExpiresAt)
	if remaining <= 0 {
		return "", errors.New("refresh token already expired")
	}
	if err = r.RedisHelper.Del(r.Ctx, r.refreshKey(oldRefreshToken)); err != nil {
		return "", err
	}
	return r.generateRefreshTokenWithTTL(p.UserID, p.TenantID, p.TenantCode, remaining)
}
