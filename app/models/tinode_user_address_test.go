package models

import "testing"

func TestTinodeUserAddressRoundTrip(t *testing.T) {
	const id uint64 = 2874855879878338592
	const address = "usrIGiX7DCK5Sc"

	if got := TinodeUserAddress(id); got != address {
		t.Fatalf("address = %s, want %s", got, address)
	}
	got, ok := ParseTinodeUserAddress("  " + address + "  ")
	if !ok || got != id {
		t.Fatalf("parse = %d ok=%v, want %d", got, ok, id)
	}
	if _, ok = ParseTinodeUserAddress("usr"); ok {
		t.Fatal("short address should be rejected")
	}
	if TinodeUserAddress(0) != "" {
		t.Fatal("zero id should have an empty address")
	}
}
