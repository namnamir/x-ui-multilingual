package entity

import (
	"crypto/tls"
	"encoding/json"
	"net"
	"strings"
	"time"
	"x-ui/util/common"
	"x-ui/xray"
)

type Msg struct {
	Success bool        `json:"success"`
	Msg     string      `json:"msg"`
	Obj     interface{} `json:"obj"`
}

type Pager struct {
	Current  int         `json:"current"`
	PageSize int         `json:"page_size"`
	Total    int         `json:"total"`
	OrderBy  string      `json:"order_by"`
	Desc     bool        `json:"desc"`
	Key      string      `json:"key"`
	List     interface{} `json:"list"`
}

type AllSetting struct {
	WebListen          string `json:"webListen" form:"webListen"`
	WebPort            int    `json:"webPort" form:"webPort"`
	WebCertFile        string `json:"webCertFile" form:"webCertFile"`
	WebKeyFile         string `json:"webKeyFile" form:"webKeyFile"`
	WebBasePath        string `json:"webBasePath" form:"webBasePath"`
	TgBotEnable        bool   `json:"tgBotEnable" form:"tgBotEnable"`
	TgBotToken         string `json:"tgBotToken" form:"tgBotToken"`
	TgBotChatId        int    `json:"tgBotChatId" form:"tgBotChatId"`
	TgRunTime          string `json:"tgRunTime" form:"tgRunTime"`
	XrayTemplateConfig string `json:"xrayTemplateConfig" form:"xrayTemplateConfig"`

	TimeLocation string `json:"timeLocation" form:"timeLocation"`
}

func (s *AllSetting) CheckValid() error {
	if s.WebListen != "" {
		ip := net.ParseIP(s.WebListen)
		if ip == nil {
			return common.NewError(tr_error_invalid_ip, s.WebListen)
		}
	}

	if s.WebPort <= 0 || s.WebPort > 65535 {
		return common.NewError(tr_error_invalid_port, s.WebPort)
	}

	if s.WebCertFile != "" || s.WebKeyFile != "" {
		_, err := tls.LoadX509KeyPair(s.WebCertFile, s.WebKeyFile)
		if err != nil {
			return common.NewErrorf(tr_error_invalid_cert, s.WebCertFile, s.WebKeyFile, err)
		}
	}

	if !strings.HasPrefix(s.WebBasePath, "/") {
		s.WebBasePath = "/" + s.WebBasePath
	}
	if !strings.HasSuffix(s.WebBasePath, "/") {
		s.WebBasePath += "/"
	}

	xrayConfig := &xray.Config{}
	err := json.Unmarshal([]byte(s.XrayTemplateConfig), xrayConfig)
	if err != nil {
		return common.NewError(tr_error_invalid_config, err)
	}

	_, err = time.LoadLocation(s.TimeLocation)
	if err != nil {
		return common.NewError(tr_error_invalid_timezone, s.TimeLocation)
	}

	return nil
}
