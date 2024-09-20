#!/bin/bash

#COLOR CODE
NC='\033[0m'
DEFBOLD='\e[39;1m'
RB='\e[31;1m'
GB='\e[32;1m'
YB='\e[33;1m'
BB='\033[0;36m'
MB='\e[0;1m'
CB='\e[35;1m'
WB='\e[37;1m'
domain=$(cat /etc/xray/domain)
IP=$(wget -qO- ipinfo.io/ip)
date=$(date +"%Y-%m-%d")
time=$(date +'%H:%M:%S')
# Restore User
echo -e "$banner" | lolcat
echo -e "$info"
echo -e "    ${BB}┌───────────────────────────────────────┐${NC}" | lolcat
echo -e "    ${WB}        ──── [ ʀᴇꜱᴛᴏʀᴇ ᴜꜱᴇʀ ] ────        ${NC}" | lolcat
echo -e "    ${BB}└───────────────────────────────────────┘${NC}" | lolcat
echo -e ""
read -p "     ʟɪɴᴋ ʙᴀᴄᴋᴜᴘ : " link
if [[ $link == "" ]]; then
echo ""
echo -e "    ${RB} ʏᴏᴜ ᴘʀᴇꜱꜱᴇᴅ ᴡʀᴏɴɢ${NC}"
menu
fi
sleep 1
echo -e "    ${GB} [ɪɴꜰᴏ] ꜱᴛᴀʀᴛ ʀᴇꜱᴛᴏʀᴇ${NC}"
# Create Restore Folder
mkdir -p /root/.restore
cd /root/.restore
wget -q -O $IP-backup.zip "$link"
unzip $IP-backup.zip > /dev/null 2>&1
# Restore SSH
cp -r /root/.restore/ssh/passwd /etc/passwd  &> /dev/null
cp -r /root/.restore/ssh/group /etc/group  &> /dev/null
cp -r /root/.restore/ssh/shadow /etc/shadow  &> /dev/null
cp -r /root/.restore/ssh/gshadow /etc/gshadow  &> /dev/null
# Restore Xray
cp -r /root/.restore/xray/config.json /etc/xray/config.json  &> /dev/null

# Restart Service
systemctl restart ssh
systemctl restart xray
echo -e "    ${GB} [ɪɴꜰᴏ] ꜱᴜᴄᴄᴇꜱꜱ ʀᴇꜱᴛᴏʀᴇ${NC}"
sleep 1

clear
cd
rm -rf /root/.restore > /dev/null 2>&1
echo -e "$banner" | lolcat
echo -e "$info"
echo -e "    ${BB}┌───────────────────────────────────────┐${NC}" | lolcat
echo -e "    ${WB}        ──── [ ʀᴇꜱᴛᴏʀ ᴜꜱᴇʀ ] ────        ${NC}" | lolcat
echo -e "    ${BB}└───────────────────────────────────────┘${NC}" | lolcat
echo -e "    ${GB}           ꜱᴜᴄᴄᴇꜱꜱ ʀᴇꜱᴛᴏʀᴇᴅ ᴜꜱᴇʀ           ${NC}"
echo -e "    ${BB} ────────────────────────────────────────${NC}" | lolcat
echo -e ""
read -n 1 -s -r -p "     ᴘʀᴇꜱꜱ ᴀɴʏ ᴋᴇʏ ᴛᴏ ʙᴀᴄᴋ ᴏɴ ᴍᴇɴᴜ"
menu
