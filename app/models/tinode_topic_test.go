package models

import (
	"encoding/json"
	"testing"
)

func TestConversationFace(t *testing.T) {
	alice := TinodeConversationUser{ID: "1", Username: "alice", Public: json.RawMessage(`{"fn":"Alice Hatter"}`)}
	bob := TinodeConversationUser{ID: "2", Username: "member10002", Public: json.RawMessage(`{"fn":"吴用"}`)}

	name, public := conversationFace("2", "p2pAbc", nil, []TinodeConversationUser{bob, alice})
	if name != "Alice Hatter" {
		t.Fatalf("peer name = %s", name)
	}
	if publicName(public) != "Alice Hatter" {
		t.Fatalf("peer public = %s", public)
	}

	name, _ = conversationFace("2", "grpAbc", json.RawMessage(`{"fn":"旅游群"}`), nil)
	if name != "旅游群" {
		t.Fatalf("group name = %s", name)
	}
	name, _ = conversationFace("2", "grpAbc", nil, nil)
	if name != "群聊" {
		t.Fatalf("empty group name = %s", name)
	}
}
