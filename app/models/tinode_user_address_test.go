package models

import (
	"encoding/base64"
	"testing"
)

func TestTinodeUserAddressRoundTrip(t *testing.T) {
	key, err := base64.StdEncoding.DecodeString("la6YsO+bNX/+XIkOqc5Svw==")
	if err != nil {
		t.Fatal(err)
	}
	if err = SetTinodeUIDKey(key); err != nil {
		t.Fatal(err)
	}

	const id uint64 = 1589474599144263680
	address := TinodeUserAddress(id)
	if address == "" || address == "usr" {
		t.Fatal("address was not encoded")
	}
	got, ok := ParseTinodeUserAddress("  " + address + "  ")
	if !ok || got != id {
		t.Fatalf("parse = %d ok=%v, want %d, address %s", got, ok, id, address)
	}

	const webAddress = "usrIGiX7DCK5Sc"
	webID, ok := ParseTinodeUserAddress(webAddress)
	if !ok {
		t.Fatal("web address should decode")
	}
	if TinodeUserAddress(webID) != webAddress {
		t.Fatalf("re-encode = %s, want %s", TinodeUserAddress(webID), webAddress)
	}
	if _, ok = ParseTinodeUserAddress("usr"); ok {
		t.Fatal("short address should be rejected")
	}
	if _, ok = ParseTinodeUserAddress("IGiX7DCK5Sc"); ok {
		t.Fatal("address without usr prefix should be rejected")
	}
	if TinodeUserAddress(0) != "" {
		t.Fatal("zero id should have an empty address")
	}
}
