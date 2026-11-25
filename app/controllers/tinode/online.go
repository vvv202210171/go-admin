package tinode

import (
	"context"
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"strings"
	"time"

	"go-admin/app/global/app"
)

func partnerBaseURL() string {
	if app.ConfigYml == nil {
		return ""
	}
	return strings.TrimSpace(app.ConfigYml.GetString("tinode.partnerurl"))
}

func partnerAPIKey() string {
	if app.ConfigYml == nil {
		return ""
	}
	return strings.TrimSpace(app.ConfigYml.GetString("tinode.partnerkey"))
}

// fetchPartnerOnline 向聊天服务查询当前已登录用户数。
func fetchPartnerOnline(ctx context.Context, baseURL, key string) (int64, error) {
	baseURL = strings.TrimRight(strings.TrimSpace(baseURL), "/")
	key = strings.TrimSpace(key)
	if baseURL == "" || key == "" {
		return 0, fmt.Errorf("未配置聊天服务地址或密钥")
	}

	reqCtx, cancel := context.WithTimeout(ctx, 3*time.Second)
	defer cancel()
	req, err := http.NewRequestWithContext(reqCtx, http.MethodGet, baseURL+"/d/online_count", nil)
	if err != nil {
		return 0, err
	}
	req.Header.Set("X-Partner-Key", key)

	resp, err := http.DefaultClient.Do(req)
	if err != nil {
		return 0, err
	}
	defer resp.Body.Close()
	body, err := io.ReadAll(io.LimitReader(resp.Body, 1<<20))
	if err != nil {
		return 0, err
	}
	var parsed struct {
		Code    int    `json:"Code"`
		Message string `json:"Message"`
		Data    struct {
			Online int64 `json:"Online"`
		} `json:"Data"`
	}
	if err = json.Unmarshal(body, &parsed); err != nil {
		return 0, err
	}
	if parsed.Code != 0 {
		if parsed.Message == "" {
			parsed.Message = "查询在线人数失败"
		}
		return 0, fmt.Errorf("%s", parsed.Message)
	}
	return parsed.Data.Online, nil
}
