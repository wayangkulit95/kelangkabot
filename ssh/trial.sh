#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
#########################
clear
# Getting

sldomain=$(cat /etc/xray/dns)
cdndomain=$(cat /root/awscdndomain)
slkey=$(cat /etc/slowdns/server.pub)
clear

cekray=`cat /root/log-install.txt | grep -ow "XRAY" | sort | uniq`
if [ "$cekray" = "XRAY" ]; then
domen=`$(cat /etc/xray/domain)`
else
domen=`$(cat /etc/v2ray/domain)`
fi
portsshws=`cat ~/log-install.txt | grep -w "SSH Websocket" | cut -d: -f2 | awk '{print $1}'`
wsssl=`cat /root/log-install.txt | grep -w "SSH SSL Websocket" | cut -d: -f2 | awk '{print $1}'`

clear
IP=$(curl -sS ifconfig.me);
ossl=`cat /root/log-install.txt | grep -w "OpenVPN" | cut -f2 -d: | awk '{print $6}'`
opensh=`cat /root/log-install.txt | grep -w "OpenSSH" | cut -f2 -d: | awk '{print $1}'`
db=`cat /root/log-install.txt | grep -w "Dropbear" | cut -f2 -d: | awk '{print $1,$2}'`
ssl="$(cat ~/log-install.txt | grep -w "Stunnel4" | cut -d: -f2)"
sqd="$(cat ~/log-install.txt | grep -w "Squid" | cut -d: -f2)"
ovpn="$(netstat -nlpt | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
ovpn2="$(netstat -nlpu | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"

OhpSSH=`cat /root/log-install.txt | grep -w "OHP SSH" | cut -d: -f2 | awk '{print $1}'`
OhpDB=`cat /root/log-install.txt | grep -w "OHP DBear" | cut -d: -f2 | awk '{print $1}'`
OhpOVPN=`cat /root/log-install.txt | grep -w "OHP OpenVPN" | cut -d: -f2 | awk '{print $1}'`

Login=trial`</dev/urandom tr -dc X-Z0-9 | head -c4`
hari="1"
Pass=1
echo Ping Host
echo Create Akun: $Login
sleep 0.5
echo Setting Password: $Pass
sleep 0.5
clear
useradd -e `date -d "$masaaktif days" +"%Y-%m-%d"` -s /bin/false -M $Login
exp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
PID=`ps -ef |grep -v grep | grep sshws |awk '{print $2}'`

if [[ ! -z "${PID}" ]]; then
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /etc/log-create-user.log
echo -e "\E[40;1;37m         MICROTECH.STORE            \E[0m" | tee -a /etc/log-create-user.log
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /etc/log-create-user.log
echo -e "Username    : $Login" | tee -a /etc/log-create-user.log
echo -e "Password    : $Pass" | tee -a /etc/log-create-user.log
echo -e "Expired On  : $exp" | tee -a /etc/log-create-user.log
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /etc/log-create-user.log
echo -e "\E[40;1;37m         SERVER INFORMATION      \E[0m" | tee -a /etc/log-create-user.log
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /etc/log-create-user.log
echo -e "IP          : $IP" | tee -a /etc/log-create-user.log
echo -e "Host        : $(cat /etc/xray/domain)" | tee -a /etc/log-create-user.log
echo -e "PubKey      : $slkey" | tee -a /etc/log-create-user.log
echo -e "Nameserver  : $sldomain" | tee -a /etc/log-create-user.log
echo -e "OpenSSH     : $opensh" | tee -a /etc/log-create-user.log
echo -e "SSH-WS      : $portsshws" | tee -a /etc/log-create-user.log
echo -e "SSH-SSL-WS  : $wsssl" | tee -a /etc/log-create-user.log
echo -e "SSL/TLS     : $ssl" | tee -a /etc/log-create-user.log
echo -e "UDPGW       : 7100-7300" | tee -a /etc/log-create-user.log
echo -e "SSH-UDP     : 1-65535" | tee -a /etc/log-create-user.log
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /etc/log-create-user.log
#echo -e "OpenVPN Config : http://$IP:81/" | tee -a /etc/log-create-user.log
#echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /etc/log-create-user.log
echo -e "Payload WSS" | tee -a /etc/log-create-user.log
echo -e "
GET wss://isi_bug_disini [protocol][crlf]Host: ${domen}[crlf]Upgrade: websocket[crlf][crlf]
" | tee -a /etc/log-create-user.log
echo -e "Payload WS" | tee -a /etc/log-create-user.log
echo -e "
GET / HTTP/1.1[crlf]Host: $domen[crlf]Upgrade: websocket[crlf][crlf]
" | tee -a /etc/log-create-user.log
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /etc/log-create-user.log

else

echo -e "\e[33m◇━━━━━━━━━━━━━━━━━◇\033[0m" | tee -a /etc/log-create-user.log
echo -e " ⟨ TRIAL SSH OVPN Account ⟩" | tee -a /etc/log-create-user.log
echo -e "\e[33m◇━━━━━━━━━━━━━━━━━◇\033[0m" | tee -a /etc/log-create-user.log
echo -e "» Username        : $Login" | tee -a /etc/log-create-user.log
echo -e "» Password        : $Pass" | tee -a /etc/log-create-user.log
echo -e "\e[33m◇━━━━━━━━━━━━━━━━━◇\033[0m" | tee -a /etc/log-create-user.log
echo -e "» Host            : $(cat /etc/xray/domain)" | tee -a /etc/log-create-user.log
echo -e "» Host Slowdns    : $sldomain" | tee -a /etc/log-create-user.log
echo -e "» Port UdpSSH     : 1-65535" | tee -a /etc/log-create-user.log                 
echo -e "» Port DNS        : 443, 53, 22" | tee -a /etc/log-create-user.log
echo -e "» Port OpenSSH    : 443, 80, 22" | tee -a /etc/log-create-user.log
echo -e "» Port Dropbear   : 443, 109" | tee -a /etc/log-create-user.log
echo -e "» Port Dropbear WS: 443, 109" | tee -a /etc/log-create-user.log
echo -e "» Port SSH WS     : 80, 8080" | tee -a /etc/log-create-user.log
echo -e "» Port SSH SSL    : 443" | tee -a /etc/log-create-user.log
echo -e "» Port SSL/TLS    : 443" | tee -a /etc/log-create-user.log
echo -e "» Port OVPN WS SSL: 443" | tee -a /etc/log-create-user.log
echo -e "» Port OVPN SSL   : 443" | tee -a /etc/log-create-user.log
echo -e "» Port OVPN TCP   : 443, 1194" | tee -a /etc/log-create-user.log
echo -e "» Port OVPN UDP   : 2200" | tee -a /etc/log-create-user.log
echo -e "» Proxy Squid     : 3128" | tee -a /etc/log-create-user.log
echo -e "» BadVPN UDP      : 7100, 7200, 7300" | tee -a /etc/log-create-user.log
echo -e "» PubKey          : $slkey" | tee -a /etc/log-create-user.log
echo -e "\e[33m◇━━━━━━━━━━━━━━━━━◇\033[0m" | tee -a /etc/log-create-user.log
echo -e "» Payload WSS     : GET wss://BUG.COM/ HTTP/1.1[crlf]Host: $(cat /etc/xray/domain)[crlf]Upgrade: websocket[crlf][crlf]" | tee -a /etc/log-create-user.log  
echo -e "\e[33m◇━━━━━━━━━━━━━━━━━◇\033[0m" | tee -a /etc/log-create-user.log
echo -e "» Link OpenVPN    : https://$(cat /etc/xray/domain):81/" | tee -a /etc/log-create-user.log
echo -e "\e[33m◇━━━━━━━━━━━━━━━━━◇\033[0m" | tee -a /etc/log-create-user.log
echo -e "» Save Link Account : https://$(cat /etc/xray/domain):81/ssh-$Login.txt" | tee -a /etc/log-create-user.log
echo -e "\e[33m◇━━━━━━━━━━━━━━━━━◇\033[0m" | tee -a /etc/log-create-user.log
echo -e "» Expired Until  : $expe" | tee -a /etc/log-create-user.log
echo -e "\e[33m◇━━━━━━━━━━━━━━━━━◇\033[0m" | tee -a /etc/log-create-user.log
fi
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
