#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
clear


NUMBER_OF_CLIENTS=$(grep -c -E "^#tr# " "/etc/xray/config.json")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        echo -e "         Padam Akaun Trojan             "
        echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
		echo ""
		echo "Anda Tidak Memiliki Member Trojan"
		echo ""
		echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
		read -n 1 -s -r -p "Press any key to back"
        menu-trojan
	fi

	clear
	echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "          Padam Akaun Trojan            "
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo "  User       Expired  " 
	echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
	grep -E "^#tr# " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq
    echo ""
    red "tap enter to go back"
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
	read -rp "Ketik Usernamenya : " user
    if [ -z $user ]; then
    menu-trojan
    else
    exp=$(grep -wE "^#tr# $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
    sed -i "/^#tr# $user $exp/,/^},{/d" /etc/xray/config.json
    systemctl restart xray > /dev/null 2>&1
    clear
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo "  Akaun Trojan Berjaya Di Padam         "
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo " Client Name : $user"
    echo " Expired On  : $exp"
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo ""
    read -n 1 -s -r -p "Press any key to back"
menu-trojan
fi
