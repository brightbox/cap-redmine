# frozen_string_literal: true

require 'capistrano/setup'
require 'capistrano/framework'

require 'capistrano/scm/plugin'
install_plugin Capistrano::SCM::Plugin

Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
