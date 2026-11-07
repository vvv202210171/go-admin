package app

import (
	"encoding/json"
	"os"
	"path/filepath"
)

type VersionInfo struct {
	Name    string `json:"name"`
	Version string `json:"version"`
}

var AppVersion VersionInfo

func LoadVersionInfo() error {
	// 在这里实现加载版本信息的逻辑
	versionPath := filepath.Join(BasePath, "version.json")
	data, error := os.ReadFile(versionPath)
	if error != nil {
		return error
	}
	return json.Unmarshal(data, &AppVersion)

}
