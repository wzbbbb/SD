#!/bin/bash
#set -x -v
heroku_link='https://s3-us-west-2.amazonaws.com/smoke-detector-staging/scripts'
yum -y -q install ruby ruby-libs ruby-shadow
yum install curl
rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm #use the new repo
yum -y -q install puppet facter
#puppet module install jfryman/nginx
curl -s -O ${heroku_link}/nginx_heroku.pp
curl -s -O ${heroku_link}/nginx.conf_template
#download and store certificate
curl -s -O ${heroku_link}/server.key
curl -s -O ${heroku_link}/server.crt
mkdir /root/sd
mv ./server.* /root/sd
#updating puppet script
IP=$1
CID=$2
conf='nginx.conf'
templ='nginx.conf_template'
sed "s/192.168.114.208/$IP/" $templ|sed "s/8888/$CID/" >$conf
puppet apply nginx_heroku.pp
#stoping firewall
/sbin/service iptables stop
#enable logrotate
curl -s -O ${heroku_link}/nginx.logrotate 
cp ./nginx.logrotate /etc/logrotate.d/nginx
#enable heartbeat
curl -s -O ${heroku_link}/heartbeat_heroku.sh_template 
hbs='heartbeat_heroku.sh'
hb_templ='heartbeat_heroku.sh_template'
sed "s/192.168.114.208/$IP/" $hb_templ >$hbs
chmod +x ./heartbeat_heroku.sh
echo '10 * * * * root ~root/heartbeat_heroku.sh' >> /etc/crontab
#prepare version control 
echo '0'>   ~/gw.version
touch ~/ready_for_upgrade 
./heartbeat_heroku.sh
rm nginx.logrotate
rm *template
rm *conf
rm *pp
