package tinode

import (
	"context"
	"net/http"
	"net/http/httptest"
	"testing"
)

func TestFetchPartnerOnline(t *testing.T) {
	if _, err := fetchPartnerOnline(context.Background(), "", "key"); err == nil {
		t.Fatal("未配置地址时应失败")
	}

	srv := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		if r.URL.Path != "/d/online_count" {
			t.Fatalf("路径 = %s", r.URL.Path)
		}
		if r.Header.Get("X-Partner-Key") != "secret" {
			w.Write([]byte(`{"Code":401,"Message":"未授权","Data":null}`))
			return
		}
		w.Write([]byte(`{"Code":0,"Message":"Success","Data":{"Online":6}}`))
	}))
	defer srv.Close()

	got, err := fetchPartnerOnline(context.Background(), srv.URL+"/", "secret")
	if err != nil || got != 6 {
		t.Fatalf("在线人数 = %d, err = %v", got, err)
	}
	if _, err = fetchPartnerOnline(context.Background(), srv.URL, "wrong"); err == nil {
		t.Fatal("错误密钥应失败")
	}
}
