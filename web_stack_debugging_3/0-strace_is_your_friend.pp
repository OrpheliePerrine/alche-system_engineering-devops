# 0-strace_is_your_friend.pp
# Fix WordPress 500 error by ensuring Apache can read files

# Ensure /var/www/html exists with correct ownership and permissions
file { '/var/www/html':
  ensure  => directory,
  owner   => 'www-data',
  group   => 'www-data',
  recurse => true,
  # Puppet allows specifying default permissions for files/dirs
  mode    => '0644',   # files default
  # Note: we will fix directories separately
}

# Fix directories specifically (permissions 755)
file { 'html_directories':
  path    => '/var/www/html',
  recurse => true,
  owner   => 'www-data',
  group   => 'www-data',
  mode    => '0755',
  recurse => true,
  ensure  => directory,
  # Only directories will be affected
  # Puppet will apply both, files stay 644
  require => File['/var/www/html'],
}

# Ensure Apache is running
service { 'apache2':
  ensure  => running,
  enable  => true,
  require => File['/var/www/html'],
}
