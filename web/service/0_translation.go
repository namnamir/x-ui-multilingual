package service

// translations

// file: /web/service/panel.go
var tr_error_sighup_logger = "Send signal SIGHUP failed: "

// file: /web/service/inbound.go
var tr_error_existing_port = "This port is already exist:"

// file: /web/service/server.go
var tr_error_get_cpu_usage_logger = "Getting CPU usage failed: "
var tr_error_get_uptime_logger = "Getting uptime failed: "
var tr_error_get_memory_logger = "Getting virtual memory failed: "
var tr_error_get_swap_logger = "Getting SWAP memory failed: "
var tr_error_get_disk_logger = "Getting disk usage failed: "
var tr_error_get_load_logger = "Getting load avg failed: "
var tr_error_get_io_logger_01 = "Getting io counters failed: "
var tr_error_get_io_logger_02 = "Can not find io counters"
var tr_error_get_tcp_logger = "Getting TCP connections failed: "
var tr_error_get_udp_logger = "Getting UDP connections failed: "
var tr_error_xray_reset_logger = "Xray restart failed: "
const tr_running = "Running"
const tr_error = "Error"
const tr_stop = "stopped"

// file: /web/service/setting.go
var tr_error_unkown_field = "Unknown field %v (type: %v)"
var tr_error_missed_key = "The key <%v> is not in defaultValueMap"
var tr_error_save_fail = "Save secret failed: "
var tr_error_missed_location = "The location <%v> not exist; using default location: %v"

// file: /web/service/user.go
var tr_error_empty_password = "The password cannot be empty"
var tr_error_empty_username = "The username cannot be empty"
var tr_error_user = "Check the user error: "

// file: /web/service/xray.go
var tr_error_xray = "Xray is not running"
var tr_xray_stop_logger = "Stop Xray"
var tr_xray_restart_logger_01 = "Restart Xray, force: "
var tr_xray_restart_logger_02 = "No need to restart Xray"
var tr_xray_version_unknown = "Unknown"