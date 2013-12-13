#include nginx
#node default {
class { 'nginx': }
#}
nginx::resource::upstream { 'proxy':
     ensure  => present,
     members => [ 'casplda02:443', ],
}

nginx::resource::vhost { "$::ipaddress":
    ensure => present,
    proxy  => 'https://proxy',
}
#    server_name =>['GW'],
#    listen_port => 80,
    #ssl         => true,
    #ssl_cert    => '/root/sd/server.crt',
    #ssl_key     => '/root/sd/server.key',
    #}
