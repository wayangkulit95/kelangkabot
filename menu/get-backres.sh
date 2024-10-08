#!/bin/bash
clear
red() { echo -e "\\033[32;1m${*}\\033[0m"; }
IP=$(curl -s ipv4.icanhazip.com)
HOST="$(cat /etc/xray/domain)"
DATEVPS=$(date +"%d-%B-%Y")
ISPVPS=$(cat /etc/xray/isp)
CITY=$(cat /etc/xray/city)
GREEN="\e[92;1m"
BLUE="\033[36m"
RED='\033[0;31m'
NC='\033[0m'

function QUESTION() {
    clear
    echo -e ""
    echo -e "${RED}Amaran !!!${NC}"
    echo -e ""
    echo -e "${RED}Sekiranya anda belum memuat naik fail anda, VPN tidak akan menyambung${NC}"
    echo -e "${BLUE}Sila masukkan sandaran data vps e -mel penerima${NC}"
    echo -e "${BLUE}Ingatkan simpan sandaran pautan untuk pemulihan data mudah${NC}"
    read -p "Sila masukkan e -mel : " EMAIL

}

function QUESTION2() {
    clear
    echo -e ""
    echo -e "${RED}Amaran !!!${NC}"
    echo -e ""
    echo -e "${RED}Sekiranya anda belum memuat naik fail anda, VPN tidak akan menyambung${NC}"
    echo -e "${BLUE}Sila masukkan sandaran data vps e -mel penerima${NC}"
    echo -e "${BLUE}Ingatkan simpan sandaran pautan untuk pemulihan data mudah${NC}"
    echo -e "Adakah anda telah memuat naik fail sandaran?"
    read -p "Pautan input plase : " DATAVPS

}

function BACKUPVPS() {
    mkdir -p /root/backup
    cp -r /etc/xray/config.json backup/ >/dev/null 2>&1
    cp /etc/passwd backup/
    cp /etc/group backup/
    cp /etc/shadow backup/
    cp /etc/gshadow backup/
    cp -r /var/www/html backup/html
    zip -r -pwokszxd wokszxd-${DATEVPS}.zip backup >/dev/null 2>&1
    rclone copy wokszxd-${DATEVPS}.zip dr:wokszxd/
    url=$(rclone link dr:wokszxd-${DATEVPS}.zip)
    id=($(echo $url | grep '^https' | cut -d'=' -f2))
    LINKBACKUP="https://drive.google.com/u/4/uc?id=${id}&export=download"
    rm -rf *
    echo "
_______________________________________
Sandaran VPS anda telah berjaya
Sila simpan data berikut
_______________________________________
YOUR VPS IP : $IP
DOMAIN      : $HOST
DATE        : $DATEVPS
ISP         : $ISPVPS
LOCATION    : $CITY
LINK BACKUP : $LINKBACKUP
_______________________________________

© Copyright By https://github.com/maeribo
Report bugs   : https://t.me/maeribo
            Microtech.Store
    " | mail -s "MTS Backup" $EMAIL
    clear
    echo -e "\033[1;93m─────────────────────────────────────────\033[0m"
    echo -e "Sandaran VPS anda telah berjaya"
    echo -e "Sila simpan data berikut"
    echo -e "\033[1;93m─────────────────────────────────────────\033[0m"
    echo -e "${BLUE}Your VPS IP${NC} : ${GREEN}$IP${NC}"
    echo -e "${BLUE}DOMAIN${NC}      : ${GREEN}$HOST${NC}"
    echo -e "${BLUE}DATE${NC}        : ${GREEN}$DATEVPS${NC}"
    echo -e "${BLUE}ISP${NC}         : ${GREEN}$ISPVPS${NC}"
    echo -e "${BLUE}LOCATION${NC}    : ${GREEN}$CITY${NC}"
    echo -e "${BLUE}LINK BACKUP${NC} : ${GREEN}$LINKBACKUP${NC}"
    echo -e "\033[1;93m─────────────────────────────────────────\033[0m"
    echo -e "${RED}Please Check your Email backup file${NC}"

}

function RESTOREVPS() {
    wget -O wokszxd.zip "$DATAVPS" >/dev/null 2>&1
    7z e -pwokszxd *.zip >/dev/null 2>&1
    #unzip *.zip >/dev/null 2>&1
    rm -f *.zip >/dev/null 2>&1
    cd /root/backup
    cp passwd /etc/
    cp group /etc/
    cp shadow /etc/
    cp gshadow /etc/
    cp -r html /var/www/
    mv *.json /etc/xray >/dev/null
    systemctl reload xray >/dev/null 2>&1
    cd
    rm -rf *
    clear
    echo -e "\033[1;93m─────────────────────────────────────────\033[0m"
    echo -e "SUCCESSFULL RESTORE YOUR VPS"
    echo -e "Please Save The Following Data"
    echo -e "\033[1;93m─────────────────────────────────────────\033[0m"
    echo -e "${BLUE}Your VPS IP${NC} : ${GREEN}$IP${NC}"
    echo -e "${BLUE}DOMAIN${NC}      : ${GREEN}$HOST${NC}"
    echo -e "${BLUE}DATE${NC}        : ${GREEN}$DATEVPS${NC}"
    echo -e "${BLUE}ISP${NC}         : ${GREEN}$ISPVPS${NC}"
    echo -e "${BLUE}LOCATION${NC}    : ${GREEN}$CITY${NC}"
    echo -e "${BLUE}LINK RESTORE${NC}: ${GREEN}$DATAVPS${NC}"
    echo -e "\033[1;93m─────────────────────────────────────────\033[0m"
    echo -e "${RED}This feature can only be used if the previous data backup uses this script${NC}"
    echo -e "${RED}Please Reboot Vps${NC}"

}

echo -e "\033[1;93m─────────────────────────────────────────\033[0m"
echo -e "\e[42m              BACKUP & RESTORE           \E[0m"
echo -e "\033[1;93m─────────────────────────────────────────\033[0m"
echo -e ""
echo -e " [${grenbo}1${NC}] ${RED}• ${NC} Backup Data VPS"
echo -e " [${grenbo}2${NC}] ${RED}• ${NC} Restore Data VPS"
echo -e ""
echo -e "\033[1;93m─────────────────────────────────────────\033[0m"
echo -e ""
read -p "Select From Options [ 1 - 2 ] : " OPT_MENU
echo -e ""
case $OPT_MENU in
1)
    QUESTION
    BACKUPVPS
    ;;
2)
    QUESTION2
    RESTOREVPS
    ;;
*)
    echo -e "${Red}You wrong command !${Font}"
    sleep 5
    menu
    ;;
esac
echo ""
read -n 1 -s -r -p "Press [ Enter ] to back on menu"

menu
