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
git_01="https://api.github.com/repos/namnamir/x-ui-multilingual/releases/latest"
git_02="https://github.com/namnamir/x-ui-multilingual/releases/download/"
git_03="https://raw.githubusercontent.com/namnamir/x-ui-multilingual/main/x-ui.sh"
line_0="\n${purple}- - - - - - - - - - - - - - - - - - - - - - - -"
line_1="${purple}- - - - - - - - - - - - - - - - - - - - - - - -\n"
architecture="\nArchitecture: "
msg_01="Error: This command should be run by the root user!\n"
msg_02="The OS version is not detected! You probably need to contact us.\n"
msg_03="Failed to Detect the architecture; it will use the default one: "
msg_04="This software does not support 32-bit system (x86), please use 64-bit system (x86_64), if the detection is wrong, please contact the us."
msg_05="This script can run on CentOS 7 or later!\n"
msg_06="This script can run on Ubuntu 16 or later!\n"
msg_07="This script can run on Debian 8 or later!\n"
msg_28="Installing ${purple}'wget'${plain}, ${purple}'curl'${plain}, and ${purple}'tar'${plain} packages.\n"
msg_08="For security reasons, the port and the account password must be changed after the installation/update is completed.\n"
msg_27="${yellow}Do you confirm? [y/n] "
msg_09="${blue}Please enter the username: "
msg_10="     └─ The username would be "
msg_11="${blue}Please enter the password: "
msg_12="     └─ The password would be "
msg_13="${blue}Please enter X-UI panel port [1-65535]: "
msg_14="     └─ The X-UI panel port would be "
msg_15="\n${yellow}Initializing the settings...\n"
msg_16="The passowrd is set successfully"
msg_17="The X-UI panel port is set successfully"
msg_18="\nThe X-UI panel default settings would be applied. Please change it later."
msg_19="Failed to detect the X-UI version. There might be an issue with Github. Please try again later or manually specify which version you would like to install."
msg_20="\nThe installation is started based on the latest version of X-UI panel: "
msg_21="Downloading the files from Github is failed. Please check if you have access to Github and the selected version is correct."
msg_22="Start Installing the X-UI Panel v"
msg_23="Failed to install the X-UI panel v"
msg_24="Please make sure this version exists."
msg_25="\nThe X-UI panel with this version is successfully installed: v."
msg_26="\n
  ${green}How to use the X-UI manamgement script${plain}
————————————————————————————————————————————————————————————————
  ${blue}x-ui              - ${plain}Show Admin Menu (more features)
  ${blue}x-ui start        - ${plain}Start X-UI Panel
  ${blue}x-ui stop         - ${plain}Stop X-UI Panel
  ${blue}x-ui restart      - ${plain}Restart X-UI Panel
  ${blue}x-ui status       - ${plain}Show X-UI Panel Status
  ${blue}x-ui enable       - ${plain}Enable X-UI Panel (to start automatically)
  ${blue}x-ui disable      - ${plain}Disable X-UI Panel (to start automatically)
  ${blue}x-ui log          - ${plain}View X-UI Log
  ${blue}x-ui v2-ui        - ${plain}Migrate from V2-UI to X-UI
  ${blue}x-ui update       - ${plain}Update X-UI
  ${blue}x-ui install      - ${plain}Install X-UI
  ${blue}x-ui uninstall    - ${plain}Uninstall X-UI
————————————————————————————————————————————————————————————————
"
msg_28="${green}Installation is started ..."

# other variables
cur_dir=$(pwd)

#Add some basic functions
function LOG() {
    echo -e "$*${plain}"
}

function LOGD() {
    echo -e "${yellow}$*${plain}"
}

function LOGE() {
    echo -e "${red}$*${plain}"
}

function LOGI() {
    echo -e "${green}$*${plain}"
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

arch=$(arch)

if [[ $arch == "x86_64" || $arch == "x64" || $arch == "amd64" ]]; then
    arch="amd64"
elif [[ $arch == "aarch64" || $arch == "arm64" ]]; then
    arch="arm64"
elif [[ $arch == "s390x" ]]; then
    arch="s390x"
else
    arch="amd64"
    LOGE "${msg_03}${yellow}${arch}"
fi

LOG "${architecture}${green}${arch}"

if [ $(getconf WORD_BIT) != '32' ] && [ $(getconf LONG_BIT) != '64' ]; then
    LOGE "${msg_04}"
    exit -1
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
        LOGE "${msg_05}" && exit 1
    fi
elif [[ x"${release}" == x"ubuntu" ]]; then
    if [[ ${os_version} -lt 16 ]]; then
        LOGE "${msg_06}" && exit 1
    fi
elif [[ x"${release}" == x"debian" ]]; then
    if [[ ${os_version} -lt 8 ]]; then
        LOGE "${msg_07}" && exit 1
    fi
fi

install_base() {
    LOG "${line_0}"
    LOG "${msg_28}"
    if [[ x"${release}" == x"centos" ]]; then
        yum install wget curl tar -y
    else
        apt install wget curl tar -y
    fi
    LOG "${line_1}"
}

#This function will be called when user installed x-ui out of sercurity
config_after_install() {
    LOGI "$msg_08"
    read -p "$(LOG "$msg_27")" config_confirm

    if [[ x"${config_confirm}" == x"y" || x"${config_confirm}" == x"Y" ]]; then
        LOG "${line_0}"
        read -p "$(LOG "${msg_09}")" config_account
        LOG "${msg_10}${green}${config_account}"
        read -p "$(LOG "${msg_11}")" config_password
        LOG "${msg_12}${green}${config_password}"
        read -p "$(LOG "${msg_13}")" config_port
        LOG "${msg_14}${green}${config_port}"
        LOG "${msg_15}"
        /usr/local/x-ui/x-ui setting -username ${config_account} -password ${config_password}
        LOG "${msg_16}"
        /usr/local/x-ui/x-ui setting -port ${config_port}
        LOG "${msg_17}"
        LOG "${line_1}"
    else
        LOGE "${msg_18}"
    fi
}

install_x-ui() {
    # stop X-UI, if is running
    systemctl stop x-ui
    cd /usr/local/

    if [ $# == 0 ]; then
        last_version=$(curl -Ls $git_01 | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
        if [[ ! -n "$last_version" ]]; then
            LOGE "${msg_19}"
            exit 1
        fi
        url="${git_02}${last_version}/x-ui-linux-${arch}.tar.gz"
        LOG "${msg_20}${green}${last_version}"
        wget -N --no-check-certificate -O /usr/local/x-ui-linux-${arch}.tar.gz ${url}
        if [[ $? -ne 0 ]]; then
            LOGE "${msg_21}"
            exit 1
        fi
    else
        last_version=$1
        url="${git_02}${last_version}/x-ui-linux-${arch}.tar.gz"
        LOGI "${msg_22}${green}$1"
        wget -N --no-check-certificate -O /usr/local/x-ui-linux-${arch}.tar.gz ${url}
        if [[ $? -ne 0 ]]; then
            LOGE "${msg_23}${yellow}$1"
            LOGE "${msg_24}"
            exit 1
        fi
    fi

    if [[ -e /usr/local/x-ui/ ]]; then
        rm -rf /usr/local/x-ui/
    fi
    
    # uncompress the package
    tar zxvf x-ui-linux-${arch}.tar.gz
    # remove the compressed package
    rm -f x-ui-linux-${arch}.tar.gz
    # go to the folder
    cd x-ui
    # make the binary files executable
    chmod +x x-ui bin/xray-linux-${arch}
    # copy the service file to the system folder
    cp -f x-ui.service /etc/systemd/system/
    # get the X-UI bash menu
    wget --no-check-certificate -O /usr/bin/x-ui ${git_03}
    # make the X-UI bash menu and the web panel executable
    chmod +x /usr/local/x-ui/x-ui.sh
    chmod +x /usr/bin/x-ui
    # run the settings for the web panel
    config_after_install
    # reload deamon and enable the service
    systemctl daemon-reload
    systemctl enable x-ui
    systemctl start x-ui
    
    LOG "${msg_25}${yellow}${last_version}\n"
    LOG "${msg_26}"
}

echo -e "${msg_28}"
install_base
install_x-ui $1
