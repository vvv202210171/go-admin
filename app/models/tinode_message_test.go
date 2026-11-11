package models

import (
	"encoding/json"
	"testing"
)

func TestMessageTypeAndText(t *testing.T) {
	cases := []struct {
		name    string
		content string
		msgType string
		text    string
	}{
		{name: "纯文本", content: `"你好"`, msgType: TinodeMsgText, text: "你好"},
		{name: "富文本", content: `{"txt":"hello"}`, msgType: TinodeMsgText, text: "hello"},
		{name: "图片", content: `{"txt":"看图","ent":[{"tp":"IM","data":{"mime":"image/jpeg","name":"a.jpg"}}]}`, msgType: TinodeMsgImage, text: "看图"},
		{name: "图片附件", content: `{"ent":[{"tp":"EX","data":{"mime":"image/png","name":"b.png"}}]}`, msgType: TinodeMsgImage, text: "b.png"},
		{name: "语音", content: `{"ent":[{"tp":"AU","data":{"mime":"audio/mpeg","name":"a.mp3"}}]}`, msgType: TinodeMsgAudio, text: "a.mp3"},
		{name: "视频", content: `{"ent":[{"tp":"VD","data":{"mime":"video/mp4","name":"a.mp4"}}]}`, msgType: TinodeMsgVideo, text: "a.mp4"},
		{name: "文件", content: `{"txt":"合同","ent":[{"tp":"EX","data":{"mime":"application/pdf","name":"a.pdf"}}]}`, msgType: TinodeMsgFile, text: "合同"},
		{name: "通话", content: `{"ent":[{"tp":"VC","data":{}}]}`, msgType: TinodeMsgCall, text: ""},
		{name: "空内容", content: ``, msgType: TinodeMsgText, text: ""},
	}
	for _, item := range cases {
		t.Run(item.name, func(t *testing.T) {
			var content json.RawMessage
			if item.content != "" {
				content = json.RawMessage(item.content)
			}
			if got := MessageType(content); got != item.msgType {
				t.Fatalf("type = %s, want %s", got, item.msgType)
			}
			if got := MessageText(content); got != item.text {
				t.Fatalf("text = %q, want %q", got, item.text)
			}
		})
	}
}

func TestTopicType(t *testing.T) {
	cases := map[string]string{
		"p2pAbcdefghijklmnop": TinodeTopicP2P,
		"grpTravel01":         TinodeTopicGrp,
		"chnTravel01":         TinodeTopicGrp,
		"slfUsrAlice":         TinodeTopicSlf,
		"sys":                 TinodeTopicSys,
		"usrAlice":            "",
		"":                    "",
	}
	for name, want := range cases {
		if got := TopicType(name); got != want {
			t.Fatalf("TopicType(%q) = %q, want %q", name, got, want)
		}
	}
}

func TestUsernameFromTags(t *testing.T) {
	if got := usernameFromTags(json.RawMessage(`["email:a@b.c","basic:member10003"]`)); got != "member10003" {
		t.Fatalf("username = %s", got)
	}
	if got := usernameFromTags(nil); got != "" {
		t.Fatalf("empty tags username = %s", got)
	}
}
