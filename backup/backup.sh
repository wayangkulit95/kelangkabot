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

# Info Token
CHATID=$(grep -E "^#bot# " "/etc/bot/.bot.db" | cut -d ' ' -f 3)
KEY=$(grep -E "^#bot# " "/etc/bot/.bot.db" | cut -d ' ' -f 2)
export TIME="10"
export URL="https://api.telegram.org/bot$KEY/sendMessage"
clear

# Info Domain
domain=$(cat /etc/xray/domain) #Ganti directory Domain lu
IP=$(wget -qO- ipinfo.io/ip);
date=$(date +"%Y-%m-%d")
time=$(date +'%H:%M:%S')

# Backup User
clear
echo -e "    ${BB}┌───────────────────────────────────────┐${NC}" | lolcat
echo -e "    ${WB}        ──── [ ʙᴀᴄᴋᴜᴘ ᴜꜱᴇʀ ] ────        ${NC}" | lolcat
echo -e "    ${BB}└───────────────────────────────────────┘${NC}" | lolcat
sleep 1
echo -e "    ${GB} [ɪɴꜰᴏ] ꜱᴛᴀʀᴛ ʙᴀᴄᴋᴜᴘ${NC}"

# Create Backup Folder
rm -rf /root/.backup
mkdir -p /root/.backup
mkdir -p /root/.backup/ssh
mkdir -p /root/.backup/xray

# Backup SSH
cp -r /etc/passwd /root/.backup/ssh/ &> /dev/null
cp -r /etc/group /root/.backup/ssh/ &> /dev/null
cp -r /etc/shadow /root/.backup/ssh/ &> /dev/null
cp -r /etc/gshadow /root/.backup/ssh/ &> /dev/null

# Backup Xray
cp -r /etc/xray/config.json /root/.backup/xray/ &> /dev/null

# Compress to zip
cd /root/.backup
zip -r $IP-backup.zip * > /dev/null 2>&1

# Send To Google-Drive (WAJIB PUNYA SCRIPT UPLOAD GOOGLE DRIVE)
id=$(gdrive upload $IP-backup.zip | grep Uploaded | awk '{print $2}')
gdrive share $id > /dev/null 2>&1
link="https://docs.google.com/uc?export=download&id=${id}"

# Send To Bot Notif
curl -F chat_id="$CHATID" -F document=@"$IP-backup.zip" -F caption="ᴛʜᴀɴᴋ ʏᴏᴜ ꜰᴏʀ ᴜꜱɪɴɢ ᴛʜɪꜱ ꜱᴄʀɪᴘᴛ
ᴅᴏᴍᴀɪɴ : $domain
ɪᴘ ᴠᴘꜱ : $IP
ᴅᴀᴛᴇ   : $date
ᴛɪᴍᴇ   : $time WIB
ʟɪɴᴋ ɢᴏᴏɢʟᴇ : $link" $URL &> /dev/null
echo -e "    ${GB} [ɪɴꜰᴏ] ꜱᴜᴄᴄᴇꜱꜱ ʙᴀᴄᴋᴜᴘ${NC}"
sleep 1

# Success Backup User
clear
cd
rm -rf /root/.backup
echo -e "    ${BB}┌───────────────────────────────────────┐${NC}" | lolcat
echo -e "    ${WB}        ──── [ ʙᴀᴄᴋᴜᴘ ᴜꜱᴇʀ ] ────        ${NC}" | lolcat
echo -e "    ${BB}└───────────────────────────────────────┘${NC}" | lolcat
echo -e "     IP VPS       : $IP"
echo -e "     Tarikh       : $date"
echo -e "     ʟɪɴᴋ ʙᴀᴄᴋᴜᴘ  : $link"
echo -e "    ${BB} ────────────────────────────────────────${NC}" | lolcat
echo -e "    ${GB}        ᴘʟᴇᴀꜱᴇ ꜱᴀᴠᴇ ᴛʜᴇ ʟɪɴᴋ ᴀʙᴏᴠᴇ        ${NC}"
echo -e "    ${BB} ────────────────────────────────────────${NC}" | lolcat
echo -e ""
read -n 1 -s -r -p "     ᴘʀᴇꜱꜱ ᴀɴʏ ᴋᴇʏ ᴛᴏ ʙᴀᴄᴋ ᴏɴ ᴍᴇɴᴜ"
menu
