package job

// translations

// file: /web/job/check_inbound_job.go
var tr_error_invalid_inbound_logger = "Disable invalid user error: "
var tr_disabled_inbound = "Disabled %v users"

// file: /web/job/stats_notify_job.go
var tr_error_tgbottoken_logger = "Failed to send message to Telegram as getting the Telegram Bot Token fail: "
var tr_error_tgbotghatid_logger = "Failed to send message to Telegram as getting the Telegram Bot Chat ID fail: "
var tr_error_tgbot = "Getting Telegram Bot error:"
var tr_tgbot_authorized = "Authorized on account %s "
var tr_error_hostname = "Getting hostname error:"
var tr_error_nic = "net.Interfaces failed:"
var tr_error_notify_logger = "Running StatsNotifyJob is failed: "
var tr_error_notify_login_logger = "Invalid UserLoginNotify info"
var tr_get_usage = "Get Usage"
var tr_callback_message_01 = "To get the bandwidth usage, send a command in this format:\n<code>/usage uuid | id</code>\n\n<b>example:</b> <code>/usage fc3239ed-8f3b-4151-ff51-b183d5182142</code>"
var tr_menu_01 = "🤖\nHow can I help you?"
var tr_menu_02 = "Hi!\n What can I help you with?"
var tr_menu_03 = "The server is up an running"
var tr_menu_04 = "It is under construction. Be patient."
var tr_menu_05 = "I could not get what you mean. /help"
var tr_info_01 = "🏠 Hostname:   %s\r\n"
var tr_info_02 = "🌐 IP Address: %s\r\n\r\n"
var tr_info_03 = "♾️ Node:       %s\r\n🔢 Port:       %d\r\n↗️ Upstream:   %s\r\n↘️ Downstream: %s\r\n🔃 Total:      %s\r\n"
var tr_info_04 = "⏰ Expires:    Never\r\n \r\n"
var tr_info_05 = "⏰ Expires:    %s\r\n \r\n"
var tr_message_01 = "Panel login success\r\n🏠 Hostname: %s\r\n"
var tr_message_02 = "Panel login failure\r\n🏠 Hostname: %s\r\n"
var tr_message_03 = "⌚ Time:       %s\r\n"
var tr_message_04 = "🧖 User:       %s\r\n"
var tr_message_05 = "🌐 IP  :       %s\r\n"

// file: /web/job/xray_traffic_job.go
var tr_error_get_traffic_logger = "Getting Xray traffic failed:"
var tr_error_add_traffic_logger = "Adding Xray traffic failed:"