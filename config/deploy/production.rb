# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

# server "example.com", user: "deploy", roles: %w{app db web}, my_property: :my_value
# server "example.com", user: "deploy", roles: %w{app web}, other_property: :other_value
# server "db.example.com", user: "deploy", roles: %w{db}

server '104.236.142.151', roles: %i[web app db docker], primary: true

namespace :docker do

  desc 'Start the docker containers'
  task :start do
    on roles :docker do
      execute "docker-compose -f #{current_path}/docker-compose-production.yml up -d"
      sleep 5
    end
  end

  desc 'Stop the docker containers'
  task :stop do
    on roles :docker do
      execute "docker-compose -f #{current_path}/docker-compose-production.yml down"
    end
  end

  desc 'Build the images for the containers'
  task :build do
    on roles :docker do
      execute "docker-compose -f #{current_path}/docker-compose-production.yml build"
    end
  end

  desc 'Restart nginx container'
  task :restart_nginx do
    on roles :docker do
      execute "docker-compose -f #{current_path}/docker-compose-production.yml build web"
      execute "docker-compose -f #{current_path}/docker-compose-production.yml up --no-deps -d web"
    end
  end

  desc 'Restart rails container'
  task :restart_rails do
    on roles :docker do
      execute "docker-compose -f #{current_path}/docker-compose-production.yml build app"
      execute "docker-compose -f #{current_path}/docker-compose-production.yml up --no-deps -d app"
    end
  end

  before :start,   :build
end

namespace :docker_rails do
  desc 'Create the DB'
  task :create_db do
    on roles :db do
      # We need to run 'sudo  echo "127.0.0.1   postgres" >> /etc/hosts'
      # before starting
      execute "docker-compose -f #{current_path}/docker-compose-production.yml exec app rails db:create RAILS_ENV=production"
    end
  end

  desc 'Run the migrations for the db'
  task :migrate do
    on roles :app do
      execute "docker-compose -f #{current_path}/docker-compose-production.yml exec app rails db:migrate RAILS_ENV=production"
    end
  end

  desc 'Precompile the assets for serving them'
  task :precompile_assets do
    on roles :app do
      execute "docker-compose -f #{current_path}/docker-compose-production.yml exec app rails assets:precompile RAILS_ENV=production"
    end
  end

  desc 'Import the elasticsearch DB'
  task :import_elasticsearch do
    on roles :app do
      execute "docker-compose -f #{current_path}/docker-compose-production.yml exec app rake environment elasticsearch:import:all FORCE=y RAILS_ENV=production"
    end
  end

  desc 'Import the old DB'
  task :import_old_db do
    on roles :app do
      execute "docker-compose -f #{current_path}/docker-compose-production.yml exec postgres dropdb --if-exists -U postgres training_prod_old"
      execute "docker-compose -f #{current_path}/docker-compose-production.yml exec postgres createdb -U postgres training_prod_old"
      execute "cat #{current_path}/backups/training_old.sql | docker  exec -i postgres psql -U postgres training_prod_old"
      execute "docker-compose -f #{current_path}/docker-compose-production.yml exec app rake db:migrate"
      execute "docker-compose -f #{current_path}/docker-compose-production.yml exec app rake old_db_import:execute"
    end
  end

  after :create_db, :migrate
end

namespace :deploy do
  desc 'Make sure local git is in sync with remote.'
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts 'WARNING: HEAD is not the same as origin/master'
        puts 'Run `git push` to sync changes.'
        exit
      end
    end
  end

  desc 'Start the application environment'
  task :start do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'docker:start'
      after  'docker:start', 'docker_rails:create_db'
      after  'docker:start', 'docker_rails:compile_assets'
    end
  end

  before :starting,     :check_revision
  after  :finishing,    :start
end




# role-based syntax
# ==================

# Defines a role with one or multiple servers. The primary server in each
# group is considered to be the first unless any hosts have the primary
# property set. Specify the username and a domain or IP for the server.
# Don't use `:all`, it's a meta role.

# role :app, %w{deploy@example.com}, my_property: :my_value
# role :web, %w{user1@primary.com user2@additional.com}, other_property: :other_value
# role :db,  %w{deploy@example.com}



# Configuration
# =============
# You can set any configuration variable like in config/deploy.rb
# These variables are then only loaded and set in this stage.
# For available Capistrano configuration variables see the documentation page.
# http://capistranorb.com/documentation/getting-started/configuration/
# Feel free to add new variables to customise your setup.



# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult the Net::SSH documentation.
# http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start
#
# Global options
# --------------
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
#
# The server-based syntax can be used to override options:
# ------------------------------------
# server "example.com",
#   user: "user_name",
#   roles: %w{web app},
#   ssh_options: {
#     user: "user_name", # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: "please use keys"
#   }