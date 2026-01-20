# 0-strace_is_your_friend.pp
# Fix WordPress 500 error by ensuring Apache can read files

# Ensure /var/www/html exists with correct ownership and permissions
file { '/var/www/html':
  ensure  => directory,
  owner   => 'www-data',
  group   => 'www-data',
  mode    => '0755',
  recurse => true,
}

# Ensure all files under /var/www/html are readable by Apache
file { '/var/www/html':
  recurse => true,
  owner   => 'www-data',
  group   => 'www-data',
  mode    => '0644',
  require => File['/var/www/html'],
}

# Make sure Apache is running and enabled
service { 'apache2':
  ensure  => running,
  enable  => true,
  require => File['/var/www/html'],
}
