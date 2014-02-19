#!/bin/bash
#set -x -v
yum -y -q install ruby ruby-libs ruby-shadow
yum install curl
rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm #use the new repo
yum -y -q install puppet facter
puppet module install jfryman/nginx
curl -s -O 192.168.115.41/download/nginx_ssl.pp_template
#download and store certificate
curl -s -O 192.168.115.41/download/server.key
curl -s -O 192.168.115.41/download/server.crt
mkdir /root/sd
mv ./server.* /root/sd
#updating puppet script
IP=$1
CID=$2
pp='nginx_ssl.pp'
templ='nginx_ssl.pp_template'
sed "s/$::ipaddress_eth1/$IP/" $templ|sed "s/8888/$CID/" >$pp
puppet apply nginx_ssl.pp
#stoping firewall
/sbin/service iptables stop
#enable logrotate
curl -s -O 192.168.115.41/download/nginx.logrotate 
cp ./nginx.logrotate /etc/logrotate.d/nginx
#enable heartbeat
curl -s -O 192.168.115.41/download/heartbeat_ssl.sh 
chmod +x ./heartbeat_ssl.sh
echo '10 * * * * root ~root/heartbeat_ssl.sh' >> /etc/crontab
#prepare version control 
echo '0'>   ~/gw.version
touch ~/ready_for_upgrade 
