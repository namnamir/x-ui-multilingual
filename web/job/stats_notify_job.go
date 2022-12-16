package job

import (
	"fmt"
	"net"
	"os"
	"time"
	"x-ui/logger"
	"x-ui/util/common"
	"x-ui/web/service"

	tgbotapi "github.com/go-telegram-bot-api/telegram-bot-api/v5"
)

type LoginStatus byte

const (
	LoginSuccess LoginStatus = 1
	LoginFail    LoginStatus = 0
)

type StatsNotifyJob struct {
	enable         bool
	xrayService    service.XrayService
	inboundService service.InboundService
	settingService service.SettingService
}

func NewStatsNotifyJob() *StatsNotifyJob {
	return new(StatsNotifyJob)
}

func (j *StatsNotifyJob) SendMsgToTgbot(msg string) {
	//Telegram bot basic info
	tgBottoken, err := j.settingService.GetTgBotToken()
	if err != nil || tgBottoken == "" {
		logger.Warning(tr_error_tgbottoken_logger, err)
		return
	}
	tgBotid, err := j.settingService.GetTgBotChatId()
	if err != nil {
		logger.Warning(tr_error_tgbotghatid_logger, err)
		return
	}

	bot, err := tgbotapi.NewBotAPI(tgBottoken)
	if err != nil {
		fmt.Println(tr_error_tgbot, err)
		return
	}
	bot.Debug = true
	fmt.Printf(tr_tgbot_authorized, bot.Self.UserName)
	info := tgbotapi.NewMessage(int64(tgBotid), msg)
	//msg.ReplyToMessageID = int(tgBotid)
	bot.Send(info)
}

//Here run is a interface method of Job interface
func (j *StatsNotifyJob) Run() {
	if !j.xrayService.IsXrayRunning() {
		return
	}
	var info string
	//get hostname
	name, err := os.Hostname()
	if err != nil {
		fmt.Println(tr_error_hostname, err)
		return
	}
	info = fmt.Sprintf(tr_info_01, name)
	//get ip address
	var ip string
	netInterfaces, err := net.Interfaces()
	if err != nil {
		fmt.Println(tr_error_nic, err.Error())
		return
	}

	for i := 0; i < len(netInterfaces); i++ {
		if (netInterfaces[i].Flags & net.FlagUp) != 0 {
			addrs, _ := netInterfaces[i].Addrs()

			for _, address := range addrs {
				if ipnet, ok := address.(*net.IPNet); ok && !ipnet.IP.IsLoopback() {
					if ipnet.IP.To4() != nil {
						ip = ipnet.IP.String()
						break
					} else {
						ip = ipnet.IP.String()
						break
					}
				}
			}
		}
	}
	info += fmt.Sprintf(tr_info_02, ip)

	//get traffic
	inbouds, err := j.inboundService.GetAllInbounds()
	if err != nil {
		logger.Warning(tr_error_notify_login_logger, err)
		return
	}
	//NOTE:If there no any sessions here,need to notify here
	//TODO:分节点推送,自动转化格式
	for _, inbound := range inbouds {
		info += fmt.Sprintf(tr_info_03, inbound.Remark, inbound.Port, common.FormatTraffic(inbound.Up), common.FormatTraffic(inbound.Down), common.FormatTraffic((inbound.Up + inbound.Down)))
		if inbound.ExpiryTime == 0 {
			info += fmt.Sprintf(tr_info_04)
		} else {
			info += fmt.Sprintf(tr_info_05, time.Unix((inbound.ExpiryTime/1000), 0).Format("2006-01-02 15:04:05"))
		}
	}
	j.SendMsgToTgbot(info)
}

func (j *StatsNotifyJob) UserLoginNotify(username string, ip string, time string, status LoginStatus) {
	if username == "" || ip == "" || time == "" {
		logger.Warning(tr_error_notify_login_logger)
		return
	}
	var msg string
	//get hostname
	name, err := os.Hostname()
	if err != nil {
		fmt.Println(tr_error_hostname, err)
		return
	}
	if status == LoginSuccess {
		msg = fmt.Sprintf(tr_message_01, name)
	} else if status == LoginFail {
		msg = fmt.Sprintf(tr_message_02, name)
	}
	msg += fmt.Sprintf(tr_message_03, time)
	msg += fmt.Sprintf(tr_message_04, username)
	msg += fmt.Sprintf(tr_message_05, ip)
	j.SendMsgToTgbot(msg)
}


var numericKeyboard = tgbotapi.NewInlineKeyboardMarkup(
    tgbotapi.NewInlineKeyboardRow(
        tgbotapi.NewInlineKeyboardButtonData(tr_get_usage, "get_usage"),
    ),
)

func (j *StatsNotifyJob) OnReceive() *StatsNotifyJob {
	tgBottoken, err := j.settingService.GetTgBotToken()
	if err != nil || tgBottoken == "" {
		logger.Warning(tr_error_tgbottoken_logger, err)
		return j
	}
	bot, err := tgbotapi.NewBotAPI(tgBottoken)
	if err != nil {
		fmt.Println(tr_error_tgbot, err)
		return j
	}
	bot.Debug = false
	u := tgbotapi.NewUpdate(0)
    u.Timeout = 10

    updates := bot.GetUpdatesChan(u)

    for update := range updates {
        if update.Message == nil { 
			
			if update.CallbackQuery != nil {
				// Respond to the callback query, telling Telegram to show the user
				// a message with the data received.
				callback := tgbotapi.NewCallback(update.CallbackQuery.ID, update.CallbackQuery.Data)
				if _, err := bot.Request(callback); err != nil {
					logger.Warning(err)
				}
	
				// And finally, send a message containing the data received.
				msg := tgbotapi.NewMessage(update.CallbackQuery.Message.Chat.ID, "")

				switch update.CallbackQuery.Data {
					case "get_usage":
						msg.Text = tr_callback_message_01
						msg.ParseMode = "HTML"
					}
				if _, err := bot.Send(msg); err != nil {
					logger.Warning(err)
				}
			}
		
            continue
        }

        if !update.Message.IsCommand() { // ignore any non-command Messages
            continue
        }

        // Create a new MessageConfig. We don't have text yet,
        // so we leave it empty.
        msg := tgbotapi.NewMessage(update.Message.Chat.ID, "")

        // Extract the command from the Message.
        switch update.Message.Command() {
        case "help":
            msg.Text = tr_menu_01
			msg.ReplyMarkup = numericKeyboard
        case "start":
            msg.Text = tr_menu_02
			msg.ReplyMarkup = numericKeyboard
        case "status":
            msg.Text = tr_menu_03
        case "usage":
            msg.Text = tr_menu_04
        default:
            msg.Text = tr_menu_05
			msg.ReplyMarkup = numericKeyboard

        }

        if _, err := bot.Send(msg); err != nil {
            logger.Warning(err)
        }
    }
	return j

}
