package models

import "testing"
import "time"

func TestFillSignupSeries(t *testing.T) {
	start := time.Date(2026, 11, 24, 0, 0, 0, 0, time.Local)
	daily := fillDailySignups(start, map[string]int64{"2026-11-24": 2, "2026-12-23": 5})
	if len(daily) != 30 || daily[0].Label != "2026-11-24" || daily[0].Total != 2 || daily[1].Total != 0 || daily[29].Total != 5 {
		t.Fatalf("日报 = %+v", daily)
	}

	monthStart := time.Date(2026, 1, 1, 0, 0, 0, 0, time.Local)
	monthly := fillMonthlySignups(monthStart, map[string]int64{"2026-01": 8})
	if len(monthly) != 12 || monthly[0].Total != 8 || monthly[1].Label != "2026-02" || monthly[11].Label != "2026-12" {
		t.Fatalf("月报 = %+v", monthly)
	}
}
