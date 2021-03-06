#include nginx
#node default {
class { 'nginx': }
#}
nginx::resource::upstream { 'proxy':
     ensure  => present,
     members => [ 'casplda02:443', ],
}

nginx::resource::vhost { "$::ipaddress_eth1":
    ensure => present,
    proxy  => 'https://proxy',
    proxy_set_header => [ 'Customer-Id 8888',
			  'User-Agent SD_TRAFFIC',
			],
    listen_port => 443,
    ssl         => true,
    ssl_cert    => '/root/sd/server.crt',
    ssl_key     => '/root/sd/server.key',
}
