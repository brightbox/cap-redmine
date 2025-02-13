# frozen_string_literal: true

# lib/capistrano/tasks/deploy.rake

namespace :deploy do
  task :starting do
    invoke 'deploy:print_config_variables' if fetch(:print_config_variables, false)
  end

  task :print_config_variables do
    puts
    puts '------- Printing current config variables -------'
    env.each_key do |config_variable_key|
      if is_question?(config_variable_key)
        puts "#{config_variable_key.inspect} => Question (awaits user input on next fetch(#{config_variable_key.inspect}))"
      else
        puts "#{config_variable_key.inspect} => #{fetch(config_variable_key).inspect}"
      end
    end

    puts
    puts '------- Printing current config variables of SSHKit mechanism -------'
    puts env.backend.config.inspect
    # puts env.backend.config.backend.config.ssh_options.inspect
    # puts env.backend.config.command_map.defaults.inspect

    puts
  end
end
