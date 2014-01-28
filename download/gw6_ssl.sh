#!/bin/bash
set -x -v
yum -y -q install ruby ruby-libs ruby-shadow
yum install curl
rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm #use the new repo
yum -y -q install puppet facter
puppet module install jfryman/nginx
curl -s -O 192.168.115.41/download/nginx_ssl.pp
curl -s -O 192.168.115.41/download/server.key
curl -s -O 192.168.115.41/download/server.crt
mkdir /root/sd
mv ./server.* /root/sd
puppet apply nginx_ssl.pp
/sbin/service iptables stop
curl -s -O 192.168.115.41/download/nginx.logrotate #enable logrotate
cp ./nginx.logrotate /etc/logrotate.d/nginx
curl -s -O 192.168.115.41/download/heartbeat_ssl.sh #enable heartbeat
chmod +x ./heartbeat.sh
echo '10 * * * * root ~root/heartbeat_ssl.sh' >> /etc/crontab
echo '0'>   ~/gw.version
touch ~/ready_for_upgrade 
