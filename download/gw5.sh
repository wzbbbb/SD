#!/bin/bash
yum -y -q install ruby ruby-libs ruby-shadow #-y: to always answer 'y'
rpm -ivh http://yum.puppetlabs.com/el/5/products/i386/puppetlabs-release-5-7.noarch.rpm # to build puppet repository
yum -y -q install puppet facter # -q to install quietly
puppet module install jfryman/nginx
curl -s -O 192.168.115.41/download/nginx.pp  # -s: silent mode
puppet apply nginx.pp
/sbin/service iptables stop
