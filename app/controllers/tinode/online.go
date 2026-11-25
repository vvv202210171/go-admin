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
	"go-admin/app/models"

	"go.uber.org/zap"
)

// StartOnlinePeakSampler 每分钟采样当前在线人数，并记下当天的最高值。
// 后台进程停着的时候不会采样，那段时间的峰值不会被记下来。
func StartOnlinePeakSampler() {
	go func() {
		sampleOnlinePeak()
		ticker := time.NewTicker(time.Minute)
		defer ticker.Stop()
		for range ticker.C {
			sampleOnlinePeak()
		}
	}()
}

func sampleOnlinePeak() {
	if partnerBaseURL() == "" || partnerAPIKey() == "" {
		return
	}
	count, err := fetchPartnerOnline(context.Background(), partnerBaseURL(), partnerAPIKey())
	if err != nil {
		app.ZapLog.Warn("采样在线人数失败", zap.Error(err))
		return
	}
	if err = models.RecordOnlinePeak(context.Background(), time.Now(), count); err != nil {
		app.ZapLog.Warn("写入每日最高在线失败", zap.Error(err))
	}
}

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
