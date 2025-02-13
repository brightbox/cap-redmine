# frozen_string_literal: true

# config/deploy/staging.rb

server 'ipv6.srv-u5kwi.gb1s.brightbox.com', user: 'fedora', roles: %w[app]

# MySQL Database Configuration (PARAMETERIZED)
set :mysql_host,     ENV.fetch('MYSQL_HOST')
set :mysql_port,     ENV.fetch('MYSQL_PORT', '3306') # Default to 3306
set :mysql_database, ENV.fetch('MYSQL_DATABASE', 'redmine')
set :mysql_username, ENV.fetch('MYSQL_USERNAME', 'admin')
set :mysql_password, ENV.fetch('MYSQL_PASSWORD')

set :redmine_image,  'docker.io/library/redmine:latest'

# Redmine Persistent Data Volume (important!)
set :redmine_volume, 'redmine_data'
