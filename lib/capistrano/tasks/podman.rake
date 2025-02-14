# frozen_string_literal: true

# lib/capistrano/tasks/podman.rake

namespace :podman do
  desc 'Check Podman connection' # Added a simple check task
  task :check do
    # Check if Podman is installed
    on roles(:app) do
      unless test 'command -v podman &> /dev/null'
        error 'Podman is not installed or not executable at /usr/bin/podman.'
        exit 1
      end
    end
  end
end

after 'deploy:starting', 'podman:check'
