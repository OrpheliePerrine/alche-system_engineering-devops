# This Puppet manifest increases Nginx worker connections to handle high traffic load

exec { 'fix--for-nginx':
  command => 'sed -i "s/worker_connections [0-9]\\+/worker_connections 1024/" /etc/nginx/nginx.conf && nginx -s reload',
  path    => ['/bin', '/usr/bin', '/sbin', '/usr/sbin'],
  onlyif  => 'grep -q "worker_connections" /etc/nginx/nginx.conf',
}
