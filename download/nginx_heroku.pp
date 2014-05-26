class nginx (){
  package {'nginx':
    ensure  => 'latest',
    require => Exec['yum-update'],
  }
  file{ 'nginx.conf':
    ensure   => file,
    require  => Package['nginx'],
    path     => '/etc/nginx/nginx.conf',
    #owner   => $user,
    #group   => $grp,
    mode     => '0644',
    source   => '/root/nginx.conf' 
  }
  service { 'nginx':
    ensure     => running,
    require    => Package['nginx'],
    #provider  => 'upstart',
    enable     => true,
    subscribe  => File['nginx.conf'],
    #start     => 'service nginx start',
    #stop      => '/usr/sbin/service nginx stop',
    #status    => '/sbin/serv',

  }
}

Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],}
exec { 'yum-update': command => 'yum -q -y update', }
include nginx


