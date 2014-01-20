# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'teamgenerator-tomoe'

set :scm, :git
set :repo_url, 'git://github.com/sunbowworld/teamgenerator-tomoe.git'
ask :branch, "develop"

set :deploy_to, "/var/www/#{fetch(:application)}"
set :format, :pretty
set :log_level, :info
set :pty, true
set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      within release_path do
        execute :rake, 'cache:clear'
      end
    end
  end

end
