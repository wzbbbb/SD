#include nginx
#node default {
class { 'nginx': }
#}
nginx::resource::upstream { 'proxy':
     ensure  => present,
     members => [ 'casplda02:443', ],
}

nginx::resource::vhost { "$::ipaddress_eth0":
    ensure => present,
    proxy  => 'https://proxy',
    proxy_set_header => [ 'Customer-Id 8908',
			  'User-Agent SD_TRAFFIC',
			]
}
nginx::resource::vhost { "$::ipaddress_eth1":
    ensure => present,
    proxy  => 'https://proxy',
    proxy_set_header => [ 'Customer-Id $2a$10$4KV/PGdp1ibfXEnOxdffKehVia905Hzldfp0t8MRKr3kIZnwG0mEG',
			  'User-Agent SD_TRAFFIC',
			],
    listen_port => 443,
    ssl         => true,
    ssl_cert    => '/root/sd/server.crt',
    ssl_key     => '/root/sd/server.key',
}
#nginx::resource::vhost { "$::ipaddress_eth2":
#    ensure => present,
#    proxy  => 'https://proxy',
#}
#    server_name =>['GW'],
#    listen_port => 80,
    #ssl         => true,
    #ssl_cert    => '/root/sd/server.crt',
    #ssl_key     => '/root/sd/server.key',
    #}
