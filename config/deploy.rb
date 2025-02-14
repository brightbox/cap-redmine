# frozen_string_literal: true

# config/deploy.rb

set :application, 'redmine'
set :systemd_unit_dir, '.config/containers/systemd'
set :systemd_local_path, 'config/quadlet'
set :quadlet_container_name, "#{fetch(:application)}.container"
set :quadlet_container_service_name, "#{fetch(:application)}.service"
set :quadlet_container_file, File.join(fetch(:systemd_local_path), fetch(:quadlet_container_name))
