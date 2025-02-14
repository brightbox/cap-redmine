# frozen_string_literal: true

# config/deploy/staging.rb

server 'ipv6.srv-q5d3t.gb1s.brightbox.com', user: 'ubuntu', roles: %w[app]
server 'ipv6.srv-xch09.gb1s.brightbox.com', user: 'fedora', roles: %w[app]

# MySQL Database Configuration (PARAMETERIZED)
set :mysql_host,     ENV.fetch('MYSQL_HOST')
set :mysql_port,     ENV.fetch('MYSQL_PORT', '3306') # Default to 3306
set :mysql_database, ENV.fetch('MYSQL_DATABASE', 'redmine')
set :mysql_username, ENV.fetch('MYSQL_USERNAME', 'admin')
set :mysql_password, ENV.fetch('MYSQL_PASSWORD')

set :redmine_image,  'docker.io/library/redmine:latest'

# Redmine Persistent Data Volume (important!)
set :redmine_volume, 'redmine_data'

# Rails cookie session data shared key
# Generate with `bundle exec rake generate_secret_token` from a Rails installation
set :secret_key_base, '9489b3eee4eccf317ed77407553e8adc97baca7c74dc7ee33cd93e4c8b69477'\
                      'eea66eaedeb18af0be2679887c7c69c0a28c0fded0a71ea472a8c4laalal19cb'
