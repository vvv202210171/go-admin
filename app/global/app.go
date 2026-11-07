package global

// App 存放全局应用信息
var App = &appInfo{}

type appInfo struct {
	BasePath string
}
