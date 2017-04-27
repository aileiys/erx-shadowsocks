#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
run_cfg=/opt/vyatta/sbin/vyatta-cfg-cmd-wrapper
run_op=/opt/vyatta/bin/vyatta-op-cmd-wrapper
#===================================================================#
#   System Required:  EdgeMax V1.9.1                                #
#   Description: Install Shadowsocks-libev For EdgeMax1.9.1         #
#   Author: landvd & aileiys                                        #
#   Thanks: @madeye <https://github.com/madeye>                     #
#===================================================================#
until
		echo "Please Select You Connect Mode"		
		echo "1.PPPOE"
		echo "2.DHCP"
		echo "3.Static Ip"
		echo "4.Exit Setup"
		read select
		test $select = 4
		do
			case $select in
			1)echo "You Select PPPOE"
			break;;
			2)echo "You Select DHCP"
			break;;
			3)echo "You Select Static ip"
			break;;
			4)echo "Exit Setup"
			exit;;
			esac
			done
until
		echo "Please Select ShadowSocks Version"		
		echo "1.ShadowSocks"
		echo "2.ShadowSocksR"
		read ssver
		test $ssver = 2
		do
			case $ssver in
			1)echo "You Select ShadowSocks"
			break;;
			2)echo "You Select ShadowSocksR"
			break;;
			esac
			done
now_ver=$(apt-cache show libc6 | grep Version)
new_ver="Version: 2.19-18+deb8u6"
if [ "$now_ver" = "$new_ver" ];then
echo "Libc6 already!Not Upgrade"
else
dpkg -i /tmp/erx-ss/libc6_2.19-18+deb8u6_mipsel.deb
fi
echo "Update System libc6 Success"
mkdir /var/configbak
cp -f /etc/crontab /var/configbak/crontab
if [ $select -eq 1 ];then
$run_cfg begin
$run_cfg set interfaces ethernet eth0 pppoe 0 name-server none
$run_cfg set service dns forwarding name-server 127.0.0.1
$run_cfg set system name-server 127.0.0.1
$run_cfg set system offload hwnat enable
$run_cfg set system offload ipsec enable
$run_cfg commit
$run_cfg save
$run_cfg end
fi
if [ $select -eq 2 ];then
$run_cfg begin
$run_cfg set service dns forwarding name-server 127.0.0.1
$run_cfg set system name-server 127.0.0.1
$run_cfg set system offload hwnat enable
$run_cfg set system offload ipsec enable
$run_cfg commit
$run_cfg save
$run_cfg end
fi
if [ $select -eq 3 ];then
$run_cfg begin
$run_cfg set service dns forwarding name-server 127.0.0.1
$run_cfg set system name-server 127.0.0.1
$run_cfg set system offload hwnat enable
$run_cfg set system offload ipsec enable
$run_cfg commit
$run_cfg save
$run_cfg end
fi
echo "BackUp InstallFile To /Var Success"
if [ $ssver -eq 1 ];then
cp -f -r /tmp/erx-ss/main/shadowsocks-libev /usr/local
fi
if [ $ssver -eq 2 ];then
cp -f -r /tmp/erx-ss/main/shadowsocks-libevR /usr/local/shadowsocks-libev
fi
cp -f -r /tmp/erx-ss/main/pcre /usr/local
cp -f -r /tmp/erx-ss/main/chinadns /usr/local
cp -f -r /tmp/erx-ss/conf/schedule /var/
cp -f -r /tmp/erx-ss/conf/crontab /etc/
ln -s /usr/local/shadowsocks-libev/bin/ss-redir /usr/bin/ss-redir
ln -s /usr/local/shadowsocks-libev/bin/ss-tunnel /usr/bin/ss-tunnel
ln -s /usr/local/chinadns/bin/chinadns /usr/bin/chinadns
ln -s /var/schedule/schedule_updata /usr/bin/schedule_updata
echo "Install Main File Success"
chmod +x /usr/local/shadowsocks-libev/bin/ss-redir
chmod +x /usr/local/shadowsocks-libev/bin/ss-tunnel
chmod +x /usr/local/chinadns/bin/chinadns
chmod +x /var/schedule/schedule_updata
chmod +x /var/schedule/gfwlist2dnsmasq_noipset.py
echo "Set MainFile Permissions Success"
    # Set shadowsocks-libev config service
    echo "Please input service for shadowsocks-libev"
    read -p "(Default service: 127.0.0.1):" shadowsocksservice
    [ -z "${shadowsocksservice}" ] && shadowsocksservice="127.0.0.1"
    echo
    echo "---------------------------"
    echo "shadowsocksservice = ${shadowsocksservice}"
    echo "---------------------------"
    echo


    # Set shadowsocks-libev config port
    echo "Please input port for shadowsocks-libev"
    read -p "(Default port: 32000):" shadowsocksport
    [ -z "${shadowsocksport}" ] && shadowsocksport="32000"
    echo
    echo "---------------------------"
    echo "shadowsocksport = ${shadowsocksport}"
    echo "---------------------------"
    echo

    # Set shadowsocks-libev config password
    echo "Please input password for shadowsocks-libev"
    read -p "(Default password: 123456):" shadowsockspwd
    [ -z "${shadowsockspwd}" ] && shadowsockspwd="123456"
    echo
    echo "---------------------------"
    echo "password = ${shadowsockspwd}"
    echo "---------------------------"
    echo

    # Set shadowsocks-libev config method
    echo "Please input method for shadowsocks-libev"
    read -p "(Default method: rc4-md5):" shadowsocksmethod
    [ -z "${shadowsocksmethod}" ] && shadowsocksmethod="rc4-md5"
    echo
    echo "---------------------------"
    echo "shadowsocksmethod= ${shadowsocksmethod}"
    echo "---------------------------"
    echo
	if [ $ssver -eq 2 ];then
	# Set shadowsocks-libev config protocol
    echo "Please input protocol for shadowsocks-libev"
    read -p "(Default protocol: origin):" shadowsocksprotocol
    [ -z "${shadowsocksprotocol}" ] && shadowsocksprotocol="origin"
    echo
    echo "---------------------------"
    echo "shadowsocksprotocol= ${shadowsocksprotocol}"
    echo "---------------------------"
    echo
	# Set shadowsocks-libev config protocol_param
    echo "Please input protocol_param for shadowsocks-libev"
    read -p "(Default protocol_param: ""):" shadowsocksprotocol_param
    [ -z "${shadowsocksprotocol_param}" ] && shadowsocksprotocol_param=""
    echo
    echo "---------------------------"
    echo "shadowsocksprotocol_param= ${shadowsocksprotocol_param}"
    echo "---------------------------"
    echo
	# Set shadowsocks-libev config obfs
    echo "Please input obfs for shadowsocks-libev"
    read -p "(Default obfs: "tls1.2_ticket_auth_compatible"):" shadowsocksobfs
    [ -z "${shadowsocksobfs}" ] && shadowsocksobfs="tls1.2_ticket_auth_compatible"
    echo
    echo "---------------------------"
    echo "shadowsocksobfs= ${shadowsocksobfs}"
    echo "---------------------------"
    echo
	# Set shadowsocks-libev config obfs_param
    echo "Please input obfs_param for shadowsocks-libev"
    read -p "(Default obfs_param: ""):" shadowsocksobfs_param
    [ -z "${shadowsocksobfs_param}" ] && shadowsocksobfs_param=""
    echo
    echo "---------------------------"
    echo "shadowsocksobfs_param= ${shadowsocksobfs_param}"
    echo "---------------------------"
    echo
	fi
    if [ ! -d /etc/shadowsocks-libev ]; then
        mkdir -p /etc/shadowsocks-libev
    fi
	if [ $ssver -eq 1 ];then
	    cat > /etc/shadowsocks-libev/config.json<<-EOF
{
    "server":"${shadowsocksservice}",
    "server_port":${shadowsocksport},
    "local_address":"0.0.0.0",
    "local_port":1080,
    "password":"${shadowsockspwd}",
    "timeout":600,
    "method":"${shadowsocksmethod}",
}
EOF
	fi
	if [ $ssver -eq 2 ];then
	    cat > /etc/shadowsocks-libev/config.json<<-EOF
{
    "server":"${shadowsocksservice}",
    "server_port":${shadowsocksport},
    "local_address":"0.0.0.0",
    "local_port":1080,
    "password":"${shadowsockspwd}",
    "timeout":600,
    "method":"${shadowsocksmethod}",
    "protocol":"${shadowsocksprotocol}",
    "protocol_param":"${shadowsocksprotocol_param}",
    "obfs":"${shadowsocksobfs}",
    "obfs_param":"${shadowsocksobfs_param}"
}
EOF
	fi

echo "write config.json success"
cp -f -r /tmp/erx-ss/conf/dnsmasq.d /etc/
cp -f -r /tmp/erx-ss/conf/post-config.d /config/scripts/
cp -f /tmp/erx-ss/conf/schedule/dnsmasq.conf /etc/
cp -f -r /tmp/erx-ss/conf/chinadns /etc/
echo "Install Configure File  Success"
cp -f -r /tmp/erx-ss/service/init.d/shadowsocks /etc/init.d/
cp -f -r /tmp/erx-ss/service/init.d/ss-tunnel /etc/init.d/
cp -f -r /tmp/erx-ss/service/init.d/chinadns /etc/init.d/
chmod +x /etc/init.d/shadowsocks
chmod +x /etc/init.d/ss-tunnel
chmod +x /etc/init.d/chinadns
chmod +x /config/scripts/post-config.d/update_iptables
sed -i "s/107.191.61.161/${shadowsocksservice}/g" /config/scripts/post-config.d/update_iptables
sed -i "s/33348/${shadowsocksport}/g" /config/scripts/post-config.d/update_iptables
update-rc.d shadowsocks defaults
update-rc.d ss-tunnel defaults
update-rc.d chinadns defaults
/etc/init.d/dnsmasq restart
/etc/init.d/shadowsocks start
/etc/init.d/ss-tunnel start
/etc/init.d/chinadns start
/config/scripts/post-config.d/update_iptables
echo "Install Service & Set Service Success"
echo "Enjoy For SS System"
