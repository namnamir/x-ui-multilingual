package controller

import (
	"net/http"
	"time"
	"x-ui/logger"
	"x-ui/web/job"
	"x-ui/web/service"
	"x-ui/web/session"

	"github.com/gin-gonic/gin"
)

type LoginForm struct {
	Username string `json:"username" form:"username"`
	Password string `json:"password" form:"password"`
}

type IndexController struct {
	BaseController

	userService service.UserService
}

func NewIndexController(g *gin.RouterGroup) *IndexController {
	a := &IndexController{}
	a.initRouter(g)
	return a
}

func (a *IndexController) initRouter(g *gin.RouterGroup) {
	g.GET("/", a.index)
	g.POST("/login", a.login)
	g.GET("/logout", a.logout)
}

func (a *IndexController) index(c *gin.Context) {
	if session.IsLogin(c) {
		c.Redirect(http.StatusTemporaryRedirect, "xui/")
		return
	}
	html(c, "login.html", tr_login_title, nil)
}

func (a *IndexController) login(c *gin.Context) {
	var form LoginForm
	err := c.ShouldBind(&form)
	if err != nil {
		pureJsonMsg(c, false, tr_error_date)
		return
	}
	if form.Username == "" {
		pureJsonMsg(c, false, tr_error_username)
		return
	}
	if form.Password == "" {
		pureJsonMsg(c, false, tr_error_password)
		return
	}
	user := a.userService.CheckUser(form.Username, form.Password)
	timeStr := time.Now().Format("2006-01-02 15:04:05")
	if user == nil {
		job.NewStatsNotifyJob().UserLoginNotify(form.Username, getRemoteIp(c), timeStr, 0)
		logger.Infof(tr_error_login_logger, form.Username, form.Password)
		pureJsonMsg(c, false, tr_error_login_web)
		return
	} else {
		logger.Infof(tr_success_login_logger_01, form.Username, getRemoteIp(c))
		job.NewStatsNotifyJob().UserLoginNotify(form.Username, getRemoteIp(c), timeStr, 1)
	}

	err = session.SetLoginUser(c, user)
	logger.Info(tr_success_login_logger_02, user.Id, tr_success_login_logger_03)
	jsonMsg(c, tr_login, err)
}

func (a *IndexController) logout(c *gin.Context) {
	user := session.GetLoginUser(c)
	if user != nil {
		logger.Info(tr_success_logout_logger_01, user.Id, tr_success_logout_logger_02)
	}
	session.ClearSession(c)
	c.Redirect(http.StatusTemporaryRedirect, c.GetString("base_path"))
}
