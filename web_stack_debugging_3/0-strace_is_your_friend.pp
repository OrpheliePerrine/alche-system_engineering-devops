# 0-strace_is_your_friend.pp
# Fix WordPress 500 error by ensuring Apache can read files

file { '/var/www/html':
  ensure  => directory,
  owner   => 'www-data',
  group   => 'www-data',
  mode    => '0755',
  recurse => true,
}

service { 'apache2':
  ensure  => running,
  enable  => true,
  require => File['/var/www/html'],
}

