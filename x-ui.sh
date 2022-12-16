#!/bin/bash

# colors
red='\e[1;31m'
green='\e[1;32m'
blue='\e[1;34m'
yellow='\e[1;33m'
purple='\e[1;36m'
plain='\e[0m'

# translation
git_bbr="https://raw.githubusercontent.com/teddysun/across/master/bbr.sh"
git_01="https://raw.githubusercontent.com/namnamir/x-ui-multilingual/master/install.sh"
git_02="https://github.com/namnamir/x-ui-multilingual/raw/master/x-ui.sh"
msg_01="Error: This command should be run by the root user!\n"
msg_02="The OS version is not detected! You probably need to contact us.\n"
msg_03="This script can run on CentOS 7 or later!\n"
msg_04="This script can run on Ubuntu 16 or later!\n"
msg_05="This script can run on Debian 8 or later!\n"
msg_06="Default:"
msg_07=" [y/n]: "
msg_08="If you restart the X-UI panel, it will restart Xray too."
msg_09="\n${blue}Press Enter to return to the main menu.\n"
msg_10="This function will (re)install the latest version forcefully (-f). However, you data would not be lost. Would you like to continue"
msg_11="Cancelled"
msg_12="The update is completed and the X-UI panel is automaticall restarted."
msg_13="If you uninstall the X-UI panel, Xray would be uninstalled too.\n${blue}Would you like to proceed?"
msg_67="${blue}Would you like to get a bakcup of the database before uninstalling X-UI? "
msg_14="\nThe uninstallation process is completed. Run ${green}rm -f /usr/bin/x-ui${plain} if you would like to delete everything.\n"
msg_15="${blue}Are you sure that you want to resetn username and password of Admin? "
msg_16="The username and password have been reset to ${green}admin${plain}. Please reset the X-UI panel."
msg_17="${blue}Are you sure that you want to reset all settings? The data would not lost and the username and password would remain the same."
msg_18="All settings have been reste to the default. Use the default port ${green}(54321)${plain} to access the X-UI panel."
msg_19="Error in getting the current settings. Please check logs."
msg_20="${blue}Enter the port number [1-65535]: "
msg_21="The port for the X-UI panel is reset. Reset the X-UI panel and use this port to access it: "
msg_22="The X-UI panel is already running. If you like to restart it, use the menu and select Reset."
msg_23="X-UI is started successfully."
msg_24="The X-UI panel is failed to be started. Please check the log for more information."
msg_25="The X-UI panel is already stopped."
msg_26="X-UI and Xray are stopped successfully."
msg_27="The X-UI panel is failed to be stopped. Please check the log for more information."
msg_28="X-UI and Xray are restarted successfully."
msg_29="The X-UI panel is failed to be restarted. Please check the log for more information."
msg_30="The X-UI is enabled successfully."
msg_31="The X-UI is failed to be enabled."
msg_32="The X-UI is disabled from autostart."
msg_33="The X-UI is failed to be disabled."
msg_34="Failed to download the Github script. Please check if you can connect to Github."
msg_35="Upgrading the script was successful. Please run the script again."
msg_36="The X-UI panel is installed successfully. Please do not reinstall it."
msg_37="Please install the X-UI panel again."
msg_38="X-UI Panel Status: ${green}Running"
msg_39="X-UI Panel Status: ${yellow}Not Running"
msg_40="X-UI Panel Status: ${red}Not Installed"
msg_41="Boot Automatically: ${green}Yes"
msg_42="Boot Automatically: ${red}No"
msg_43="Xray Status: ${green}Running"
msg_44="Xray Status: ${red}Not Running"
msg_45="\n
${yellow}******Instructions******${plain}\n
This script will use the ACME script to issue a certificate. Before you go further, make sure that you:
1. Know the Cloudflare registered email address.
2. Know Cloudflare Global API Key.
3. The domain name that is set on the current server by Cloudflare.
4. The default installation path for this script to apply for a certificate is the /root/cert directory.
"
msg_46=""
msg_47="${blue}I confirm the above items [y/n] "
msg_48="Install ACME script"
msg_49="Failed to install ACME script"
msg_50="${blue}Please enter your domain name: "
msg_51="     └─ Your domain name is set to: "
msg_52="${blue}Please enter your Cloudflare Global API Key: "
msg_53="     └─ Your API key is set to: "
msg_54="${blue}Please enter your Cloudflare email address: "
msg_55="     └─ Your email address is set to: "
msg_56="Modifying the default CA to Let's Encrypt failed. Running the script will be terminated."
msg_57="Failed to issue the certificate. Running the script will be terminated."
msg_58="Issuing the certificate is in progress ..."
msg_59="The certificate is issued successfully. Enabling the automatic update ..."
msg_60="There was an error in enabling the automatic update. Running the script will be terminated."
msg_61="The certificate has been issued successfully and the automatic renewal is enabled."
msg_62="\n
  ${green}How to use the X-UI manamgement script${plain}
————————————————————————————————————————————————————————————————
  ${blue}x-ui              - ${plain}Show Admin Menu (more features)
  ${blue}x-ui start        - ${plain}Start X-UI Panel
  ${blue}x-ui stop         - ${plain}Stop X-UI Panel
  ${blue}x-ui restart      - ${plain}Restart X-UI Panel
  ${blue}x-ui status       - ${plain}Show X-UI Panel Status
  ${blue}x-ui backup       - ${plain}Get X-UI Database Backup
  ${blue}x-ui enable       - ${plain}Enable X-UI Panel (to start automatically)
  ${blue}x-ui disable      - ${plain}Disable X-UI Panel (to start automatically)
  ${blue}x-ui log          - ${plain}View X-UI Log
  ${blue}x-ui v2-ui        - ${plain}Migrate from V2-UI to X-UI
  ${blue}x-ui update       - ${plain}Update X-UI
  ${blue}x-ui install      - ${plain}Install X-UI
  ${blue}x-ui uninstall    - ${plain}Uninstall X-UI
————————————————————————————————————————————————————————————————
"
msg_63="
  ${green}X-UI Panel Management${plain}
————————————————————————————————  
  ${blue} 0.${plain} Exit the Script
————————————————————————————————
  ${blue} 1.${plain} Install X-UI
  ${blue} 2.${plain} Update X-UI
  ${blue} 3.${plain} Uninstall X-UI
————————————————————————————————
  ${blue} 4.${plain} Reset Username & Password
  ${blue} 5.${plain} Reset X-UI Panel Settings
  ${blue} 6.${plain} Change the X-UI Panel Port
  ${blue} 7.${plain} View the Current X-UI Panel Settings
————————————————————————————————
  ${blue} 8.${plain} Start X-UI
  ${blue} 9.${plain} Stop X-UI
  ${blue}10.${plain} Restart X-UI
  ${blue}11.${plain} View X-UI Status
  ${blue}12.${plain} View X-UI Logs
————————————————————————————————
  ${blue}13.${plain} Enable X-UI Panel (to start automatically)
  ${blue}14.${plain} Disable X-UI Panel (to start automatically)
————————————————————————————————
  ${blue}15.${plain} One-Click Installation of BBR (Latest Kernel)
  ${blue}16.${plain} One-Click SSL Certificate Installation (ACME)
  ${blue}17.${plain} Backup X-UI Database
————————————————————————————————

"
msg_64="Please Select the Item [0-17]: "
msg_65="Please enter a correct number [0-17]\n"
msg_66="\nThe backup of the database is generated and located in "

#Add some basic function here
function LOG() {
    echo -e "$*${plain}"
}

function LOGD() {
    echo -e "\n${yellow}[DEG] $*${plain}"
}

function LOGE() {
    echo -e "\n${red}[ERR] $*${plain}"
}

function LOGI() {
    echo -e "\n${green}[INF] $*${plain}"
}

# check root
[[ $EUID -ne 0 ]] && LOGE "${msg_01}" && exit 1

# check os
if [[ -f /etc/redhat-release ]]; then
    release="centos"
elif cat /etc/issue | grep -Eqi "debian"; then
    release="debian"
elif cat /etc/issue | grep -Eqi "ubuntu"; then
    release="ubuntu"
elif cat /etc/issue | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
elif cat /proc/version | grep -Eqi "debian"; then
    release="debian"
elif cat /proc/version | grep -Eqi "ubuntu"; then
    release="ubuntu"
elif cat /proc/version | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
else
    LOGE "${msg_02}" && exit 1
fi

os_version=""

# os version
if [[ -f /etc/os-release ]]; then
    os_version=$(awk -F'[= ."]' '/VERSION_ID/{print $3}' /etc/os-release)
fi
if [[ -z "$os_version" && -f /etc/lsb-release ]]; then
    os_version=$(awk -F'[= ."]+' '/DISTRIB_RELEASE/{print $2}' /etc/lsb-release)
fi

if [[ x"${release}" == x"centos" ]]; then
    if [[ ${os_version} -le 6 ]]; then
        LOGE "${msg_03}" && exit 1
    fi
elif [[ x"${release}" == x"ubuntu" ]]; then
    if [[ ${os_version} -lt 16 ]]; then
        LOGE "${msg_04}" && exit 1
    fi
elif [[ x"${release}" == x"debian" ]]; then
    if [[ ${os_version} -lt 8 ]]; then
        LOGE "${msg_05}" && exit 1
    fi
fi

confirm() {
    if [[ $# > 1 ]]; then
        echo && read -p "$(LOG $1" [${msg_06}" $2"]: ")" temp
        if [[ x"${temp}" == x"" ]]; then
            temp=$2
        fi
    else
        read -p "$(LOG $1 "${msg_07}")" temp
    fi
    if [[ x"${temp}" == x"y" || x"${temp}" == x"Y" ]]; then
        return 0
    else
        return 1
    fi
}

confirm_restart() {
    confirm "${msg_08}" "y"
    if [[ $? == 0 ]]; then
        restart
    else
        show_menu
    fi
}

before_show_menu() {
    echo && echo -n -e "${msg_09}" && read temp
    show_menu
}

install() {
    bash <(curl -Ls ${git_01})
    if [[ $? == 0 ]]; then
        if [[ $# == 0 ]]; then
            start
        else
            start 0
        fi
    fi
}

update() {
    confirm "${msg_10}" "n"
    if [[ $? != 0 ]]; then
        LOGE "${msg_11}"
        if [[ $# == 0 ]]; then
            before_show_menu
        fi
        return 0
    fi
    bash <(curl -Ls "${git_01}")
    if [[ $? == 0 ]]; then
        LOGI "${msg_12}"
        exit 0
    fi
}

uninstall() {
    confirm "${msg_13}" "n"
    
    if [[ $? != 0 ]]; then
        if [[ $# == 0 ]]; then
            show_menu
        fi
        return 0
    fi

    systemctl stop x-ui
    systemctl disable x-ui
    rm -f /etc/systemd/system/x-ui.service
    systemctl daemon-reload
    systemctl reset-failed
    rm -rf /etc/x-ui/
    rm -rf /usr/local/x-ui/
    # rm -f /usr/bin/x-ui

    LOG "${msg_14}"

    if [[ $# == 0 ]]; then
        before_show_menu
    fi
}

reset_user() {
    confirm "${msg_15}" "n"
    if [[ $? != 0 ]]; then
        if [[ $# == 0 ]]; then
            show_menu
        fi
        return 0
    fi
    /usr/local/x-ui/x-ui setting -username admin -password admin
    LOG "${msg_16}"
    confirm_restart
}

reset_config() {
    confirm "${msg_17}" "n"
    if [[ $? != 0 ]]; then
        if [[ $# == 0 ]]; then
            show_menu
        fi
        return 0
    fi
    /usr/local/x-ui/x-ui setting -reset
    LOG "${msg_18}"
    confirm_restart
}

check_config() {
    info=$(/usr/local/x-ui/x-ui setting -show true)
    if [[ $? != 0 ]]; then
        LOGE "${msg_19}"
        show_menu
    fi
    LOGI $info
}

set_port() {
    echo && echo -n -e "${msg_20}" && read port
    if [[ -z "${port}" ]]; then
        LOGD "${msg_11}"
        before_show_menu
    else
        /usr/local/x-ui/x-ui setting -port ${port}
        LOG "${msg_21}${green}${port}"
        confirm_restart
    fi
}

start() {
    check_status
    if [[ $? == 0 ]]; then
        LOGI "${msg_22}"
    else
        systemctl start x-ui
        sleep 2
        check_status
        if [[ $? == 0 ]]; then
            LOGI "${msg_23}"
        else
            LOGE "${msg_24}"
        fi
    fi

    if [[ $# == 0 ]]; then
        before_show_menu
    fi
}

stop() {
    check_status
    if [[ $? == 1 ]]; then
        LOGI "${msg_25}"
    else
        systemctl stop x-ui
        sleep 2
        check_status
        if [[ $? == 1 ]]; then
            LOGI "${msg_26}"
        else
            LOGE "${msg_27}"
        fi
    fi

    if [[ $# == 0 ]]; then
        before_show_menu
    fi
}

restart() {
    systemctl restart x-ui
    sleep 2
    check_status
    if [[ $? == 0 ]]; then
        LOGI "${msg_28}"
    else
        LOGE "${msg_29}"
    fi
    if [[ $# == 0 ]]; then
        before_show_menu
    fi
}

status() {
    systemctl status x-ui -l
    if [[ $# == 0 ]]; then
        before_show_menu
    fi
}

enable() {
    systemctl enable x-ui
    if [[ $? == 0 ]]; then
        LOGI "${msg_30}"
    else
        LOGE "${msg_31}"
    fi

    if [[ $# == 0 ]]; then
        before_show_menu
    fi
}

disable() {
    systemctl disable x-ui
    if [[ $? == 0 ]]; then
        LOGI "${msg_32}"
    else
        LOGE "${msg_33}"
    fi

    if [[ $# == 0 ]]; then
        before_show_menu
    fi
}

show_log() {
    journalctl -u x-ui.service -e --no-pager -f
    if [[ $# == 0 ]]; then
        before_show_menu
    fi
}

migrate_v2_ui() {
    /usr/local/x-ui/x-ui v2-ui

    before_show_menu
}

install_bbr() {
    # temporary workaround for installing bbr
    bash <(curl -L -s "${git_bbr}")
    before_show_menu
}

update_shell() {
    wget -O /usr/bin/x-ui -N --no-check-certificate ${git_02}
    if [[ $? != 0 ]]; then
        LOGE "${msg_34}"
        before_show_menu
    else
        chmod +x /usr/bin/x-ui
        LOGI "${msg_35}" && exit 0
    fi
}

# 0: running, 1: not running, 2: not installed
check_status() {
    if [[ ! -f /etc/systemd/system/x-ui.service ]]; then
        return 2
    fi
    temp=$(systemctl status x-ui | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
    if [[ x"${temp}" == x"running" ]]; then
        return 0
    else
        return 1
    fi
}

check_enabled() {
    temp=$(systemctl is-enabled x-ui)
    if [[ x"${temp}" == x"enabled" ]]; then
        return 0
    else
        return 1
    fi
}

check_uninstall() {
    check_status
    if [[ $? != 2 ]]; then
        LOGE "${msg_36}"
        if [[ $# == 0 ]]; then
            before_show_menu
        fi
        return 1
    else
        return 0
    fi
}

check_install() {
    check_status
    if [[ $? == 2 ]]; then
        LOGE "${msg_37}"
        if [[ $# == 0 ]]; then
            before_show_menu
        fi
        return 1
    else
        return 0
    fi
}

show_status() {
    check_status
    case $? in
    0)
        LOG "${msg_38}"
        show_enable_status
        ;;
    1)
        LOG "${msg_39}"
        show_enable_status
        ;;
    2)
        LOG "${msg_40}"
        ;;
    esac
    show_xray_status
}

show_enable_status() {
    check_enabled
    if [[ $? == 0 ]]; then
        LOG "${msg_41}"
    else
        LOG "${msg_42}"
    fi
}

check_xray_status() {
    count=$(ps -ef | grep "xray-linux" | grep -v "grep" | wc -l)
    if [[ count -ne 0 ]]; then
        return 0
    else
        return 1
    fi
}

show_xray_status() {
    check_xray_status
    if [[ $? == 0 ]]; then
        LOG "${msg_43}"
    else
        LOG "${msg_44}"
    fi
}

ssl_cert_issue() {
    LOG "${msg_45}"
    confirm "${msg_47}" "y"
    if [ $? -eq 0 ]; then
        cd ~
        LOGI "${msg_48}"
        curl https://get.acme.sh | sh
        if [ $? -ne 0 ]; then
            LOGE "${msg_49}"
            exit 1
        fi
        CF_Domain=""
        CF_GlobalKey=""
        CF_AccountEmail=""
        certPath=/root/cert
        if [ ! -d "$certPath" ]; then
            mkdir $certPath
        else
            rm -rf $certPath
            mkdir $certPath
        fi
        read -p "$(LOG "${msg_50}")" CF_Domain
        LOG "${msg_51}${green}${CF_Domain}"
        read -p "$(LOG "${msg_52}")" CF_GlobalKey
        LOG "${msg_53}${green}${CF_GlobalKey}"
        read -p "$(LOG "${msg_54}")" CF_AccountEmail
        LOG "${msg_55}${green}${CF_AccountEmail}"
        ~/.acme.sh/acme.sh --set-default-ca --server letsencrypt
        if [ $? -ne 0 ]; then
            LOGE "${msg_56}"
            exit 1
        fi
        export CF_Key="${CF_GlobalKey}"
        export CF_Email=${CF_AccountEmail}
        ~/.acme.sh/acme.sh --issue --dns dns_cf -d ${CF_Domain} -d *.${CF_Domain} --log
        if [ $? -ne 0 ]; then
            LOGE "${msg_57}"
            exit 1
        else
            LOGI "${msg_58}"
        fi
        ~/.acme.sh/acme.sh --installcert -d ${CF_Domain} -d *.${CF_Domain} --ca-file /root/cert/ca.cer \
        --cert-file /root/cert/${CF_Domain}.cer --key-file /root/cert/${CF_Domain}.key \
        --fullchain-file /root/cert/fullchain.cer
        if [ $? -ne 0 ]; then
            LOGE "${msg_57}"
            exit 1
        else
            LOGI "${msg_59}"
        fi
        ~/.acme.sh/acme.sh --upgrade --auto-upgrade
        if [ $? -ne 0 ]; then
            LOGE "${msg_60}"
            ls -lah cert
            chmod 755 $certPath
            exit 1
        else
            LOGI "${msg_61}"
            ls -lah cert
            chmod 755 $certPath
        fi
    else
        show_menu
    fi
}

backup_db() {
    db_file=/etc/x-ui/x-ui.db
    if [ -f "$db_file" ]; then
        backup_folder=$HOME/x-ui-db-backup/
        if ! [ -d "$backup_folder" ]; then
            mkdir $backup_folder
        fi
        cp $db_file $backup_folder"/x-ui_$(date +%s).db"
        LOG "${msg_66}${green}$backup_folder"
    fi
    if [[ $# == 0 ]]; then
        before_show_menu
    fi
}

show_usage() {
    LOG "${msg_62}"
}

show_menu() {
    LOG "${msg_63}"
    show_status
    echo && read -p "$(LOG "${msg_64}")" num
    echo ""

    case "${num}" in
    0)
        exit 0
        ;;
    1)
        check_uninstall && install
        ;;
    2)
        check_install && update
        ;;
    3)
        check_install && uninstall
        ;;
    4)
        check_install && reset_user
        ;;
    5)
        check_install && reset_config
        ;;
    6)
        check_install && set_port
        ;;
    7)
        check_install && check_config
        ;;
    8)
        check_install && start
        ;;
    9)
        check_install && stop
        ;;
    10)
        check_install && restart
        ;;
    11)
        check_install && status
        ;;
    12)
        check_install && show_log
        ;;
    13)
        check_install && enable
        ;;
    14)
        check_install && disable
        ;;
    15)
        install_bbr
        ;;
    16)
        ssl_cert_issue
        ;;
    17)
        backup_db
        ;;
    *)
        LOGE "${msg_65}"
        ;;
    esac
}

if [[ $# > 0 ]]; then
    case $1 in
    "start")
        check_install 0 && start 0
        ;;
    "stop")
        check_install 0 && stop 0
        ;;
    "restart")
        check_install 0 && restart 0
        ;;
    "status")
        check_install 0 && status 0
        ;;
    "backup")
        check_install 0 && backup_db 0
        ;;
    "enable")
        check_install 0 && enable 0
        ;;
    "disable")
        check_install 0 && disable 0
        ;;
    "log")
        check_install 0 && show_log 0
        ;;
    "v2-ui")
        check_install 0 && migrate_v2_ui 0
        ;;
    "update")
        check_install 0 && update 0
        ;;
    "install")
        check_uninstall 0 && install 0
        ;;
    "uninstall")
        check_install 0 && uninstall 0
        ;;
    *) show_usage ;;
    esac
else
    show_menu
fi
