package{"pcre":
  ensure=>present,
  before=>Package["nginx"],
}
package{"httpd-devel":
  ensure=>present,
  before=>Package["nginx"],
}
package{"perl":
  ensure=>present,
  before=>Package["nginx"],
}
package{"pcre-devel":
  ensure=>present,
  before=>Package["nginx"],
}
package{"zlib":
  ensure=>present,
  before=>Package["nginx"],
}
package{"zlib-devel":
  ensure=>present,
  before=>Package["nginx"],
}
package{"GeoIP":
  ensure=>present,
  before=>Package["nginx"],
}
package{"GeoIP-devel":
  ensure=>present,
  before=>Package["nginx"],
}

#yum install -y httpd-devel pcre perl pcre-devel zlib zlib-devel GeoIP GeoIP-devel

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
