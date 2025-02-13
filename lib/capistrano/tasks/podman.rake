# frozen_string_literal: true

# lib/capistrano/tasks/podman.rake

namespace :podman do
  desc 'Create the Redmine container'
  task :create do
    on roles(:app) do
      unless test(:podman, :container, :exists, fetch(:application))
        # 5. Run the Redmine container, passing MySQL parameters as environment variables
        execute :podman, :container, :create,
                '--network host ' \
                '--log-driver journald ' \
                '--label "io.containers.autoupdate=registry" ' \
                '--stop-timeout 90 ' \
                "--name '#{fetch(:application)}' " \
                "-v #{fetch(:redmine_volume)}:/usr/src/redmine/files " \
                "-e REDMINE_DB_MYSQL=#{fetch(:mysql_host)} " \
                "-e REDMINE_DB_PORT=#{fetch(:mysql_port)} " \
                "-e REDMINE_DB_DATABASE=#{fetch(:mysql_database)} " \
                "-e REDMINE_DB_USERNAME=#{fetch(:mysql_username)} " \
                "-e REDMINE_DB_PASSWORD=#{fetch(:mysql_password)} ",
                fetch(:redmine_image)

        info 'Redmine container created'
      end
    end
  end

  task :pull do
    on roles(:app) do
      # 4. Pull the Redmine image
      execute :podman, :pull, fetch(:redmine_image)
    end
  end

  task :start do
    on roles(:app) do
      execute :podman, :start, fetch(:application)
    end
  end

  task :restart do
    on roles(:app) do
      execute :podman, :restart, fetch(:application)
    end
  end

  task :stop do
    on roles(:app) do
      # 4. Pull the Redmine image
      execute :podman, :stop, fetch(:application)
    end
  end

  task :prune do
    on roles(:app) do
      execute :podman, :system, :prune, '-f'
    end
  end

  task :check do
    invoke 'podman:check:podman'
    invoke 'podman:check:volumes'
  end

  namespace :check do
    desc 'Check Podman connection' # Added a simple check task
    task :podman do
      # Check if Podman is installed
      on roles(:app) do
        unless test('[ -x /usr/bin/podman ]')
          error 'Podman is not installed or not executable at /usr/bin/podman.'
          exit 1
        end
      end
    end

    desc 'Check Redmine Volume'
    task :volumes do
      on roles(:app) do
        unless test(:podman, :volume, :exists, fetch(:redmine_volume))
          execute :podman, :volume, :create, fetch(:redmin_volume)
        end
      end
    end
  end
end

after 'deploy:starting', 'podman:check'
after 'deploy:updating', 'podman:pull'
after 'deploy:updating', 'podman:create'
after 'deploy:updated', 'podman:start'
after 'deploy:finished', 'podman:prune'
