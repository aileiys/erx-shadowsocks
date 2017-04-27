#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
#===================================================================#
#   System Required:  EdgeMax V1.9                                  #
#   Description: Install Shadowsocks-libev For EdgeMax1.9           #
#   Author: landvd <5586822@qq.com>                                 #
#   Thanks: @madeye <https://github.com/madeye>                     #
#                                                                   #
#===================================================================#
/etc/init.d/shadowsocks stop
/etc/init.d/ss-tunnel stop
/etc/init.d/chinadns stop
update-rc.d -f shadowsocks remove
update-rc.d -f ss-tunnel remove
update-rc.d -f chinadns remove
rm -f /etc/init.d/shadowsocks
rm -f /etc/init.d/ss-tunnel
rm -f /etc/init.d/chinadns
rm -f /config/scripts/post-config.d/update_iptables
rm -f /etc/dnsmasq.d/*.*
rm -fr /usr/local/shadowsocks-libev
rm -fr /usr/local/chinadns
rm -fr /usr/local/pcre
rm -fr /etc/chinadns
rm -fr /etc/shadowsocks-libev
rm -fr /var/schedule
cp -f /var/configbak/crontab /etc
rm -f /usr/bin/ss-redir
rm -f /usr/bin/ss-tunnel
rm -f /usr/bin/chinadns
rm -f /usr/bin/schedule_updata
echo echo "Shadowsocks-libev uninstall success!"
