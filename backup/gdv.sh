#!/bin/bash

# Code Color
NC='\e[0m'
RB='\e[31;1m'
GB='\e[32;1m'
YB='\e[33;1m'
BB='\e[34;1m'
PB='\e[35;1m'
RW='\e[41;1m'
GW='\e[42;1m'
BW='\e[44;1m'
PW='\e[45;1m'
DBW='\e[46;1m'
WW='\e[47;1m'
DB='\e[90;1m'

# Information Repositories Google Drive
ID_gdrive=""

# Tools Download With Curl
function download_file() {
  curl -sL "https://drive.usercontent.google.com/download?id=$1&confirm=t" -o $2
}

# Print Install
function print_install() {
  clear
  echo -e "${BB} ┌─────────────────────────────────────────────────────┐${NC}"
  echo -e "${GB}             ──── [ $1 ] ────${NC}"
  echo -e "${BB} └─────────────────────────────────────────────────────┘${NC}"
  sleep 1
}

# Print INFO
function print_info() {
  echo -e "${BB}[${NC}${GB} ɪɴꜰᴏ ${NC}${BB}]${NC} $1"
  sleep 1
}

# Print Success
function print_success() {
  echo -e "${BB}[${NC}${GB} ɪɴꜰᴏ ${NC}${BB}]${NC}${GB} ꜱᴜᴄᴄᴇꜱꜱ $1${NC}"
}

# validation file
function val_file() {
if [ -f "/root/.gdrive" ];then
  rm -rf /root/.gdrive
fi
if [ -f "/bin/gdrive" ];then
  echo -ne
else
  download_file $ID_gdrive gdrive
fi
}

# information account gdrive
function user_gdrive() {
  User=$(gdrive about | grep User: | awk '{print $2,$3}')
  Email=$(gdrive about | grep User: | awk '{print $4}')
  Used=$(gdrive about | grep Used: | awk '{print $2,$3}')
  Free=$(gdrive about | grep Free: | awk '{print $2,$3}')
  Total=$(gdrive about | grep Total: | awk '{print $2,$3}')
  echo -e "${BB}[${NC}${PB} ᴜꜱᴇʀ ${NC}${BB}]${NC} $User"
  echo -e "${BB}[${NC}${PB} ᴇᴍᴀɪʟ${NC}${BB}]${NC} $Email"
  echo -e "${BB}[${NC}${PB} ᴜꜱᴇᴅ ${NC}${BB}]${NC} $Used"
  echo -e "${BB}[${NC}${PB} ꜰʀᴇᴇ ${NC}${BB}]${NC} $Free"
  echo -e "${BB}[${NC}${PB} ᴛᴏᴛᴀʟ${NC}${BB}]${NC} $Total"
}

# Setup token
function add_token() {
  print_install "ᴀᴅᴅ ɪᴅ ᴀᴘɪ ᴛᴏᴋᴇɴ"
  echo -e "  ID token that you previously backup to Google Drive"
  read -p "  ʏᴏᴜʀ ɪᴅ ᴛᴏᴋᴇɴ : " ID_api_gd
}

# Setup gdrive file
function install_gdrive() {
  print_install "ɪɴꜱᴛᴀʟʟ ɢᴅʀɪᴠᴇ ʙᴀᴄᴋᴜᴘ"
  cd /bin
  print_info "ᴄʀᴇᴀᴛᴇ ꜰᴏʟᴅᴇʀ"
  val_file
  mkdir -p /root/.gdrive
  print_info "ᴅᴏᴡɴʟᴏᴀᴅ ꜰɪʟᴇ"
  download_file $ID_api_gd /root/.gdrive/token_v2.json
  chmod +x gdrive
  cd
  print_info "ɪɴꜰᴏʀᴍᴀᴛɪᴏɴ ᴀᴄᴄᴏᴜɴᴛ"
  user_gdrive
  rm -rf gd
  print_success "ɪɴꜱᴛᴀʟʟ ɢᴅʀɪᴠᴇ"
}
add_token
install_gdrive
