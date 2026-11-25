package common

import "testing"

func TestIsBuiltinMenuAPI(t *testing.T) {
	if !IsBuiltinMenuAPI("/api/tinodeUser/list", "GET") {
		t.Fatal("user list should be allowed")
	}
	if !IsBuiltinMenuAPI("/api/tinodeMessage/list", "GET") {
		t.Fatal("message list should be allowed")
	}
	if !IsBuiltinMenuAPI("/api/tinodeMessage/topic/list", "GET") {
		t.Fatal("topic list should be allowed")
	}
	if !IsBuiltinMenuAPI("/api/tinodeUser/summary", "GET") {
		t.Fatal("home summary should be allowed")
	}
	if IsBuiltinMenuAPI("/api/tinodeUser/list", "POST") {
		t.Fatal("non-GET should not match")
	}
	if IsBuiltinMenuAPI("/api/users/list", "GET") {
		t.Fatal("other list APIs should stay under casbin")
	}
}
