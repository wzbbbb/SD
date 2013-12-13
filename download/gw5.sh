#!/bin/bash
yum -y -q install ruby ruby-libs ruby-shadow
rpm -ivh http://yum.puppetlabs.com/el/5/products/i386/puppetlabs-release-5-7.noarch.rpm
yum -y -q install puppet facter
puppet module install jfryman/nginx
curl -s -O 192.168.115.41/download/nginx.pp
puppet apply nginx.pp
/sbin/service iptables stop
