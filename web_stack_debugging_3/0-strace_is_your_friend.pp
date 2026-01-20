# Fix WordPress 500 error by ensuring Apache can read the files

# Set ownership and permissions for all WordPress files
file { '/var/www/html':
  ensure  => directory,
  owner   => 'www-data',
  group   => 'www-data',
  recurse => true,
}

# Optional: restart Apache to apply changes
service { 'apache2':
  ensure  => running,
  enable  => true,
  require => File['/var/www/html'],
}
