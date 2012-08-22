# Deployment Rake Tasks

##
#  Deploy
#
desc 'Deploy, migrate and restart processes'
task :deploy => 'deploy:deploy_and_migrate'

namespace :deploy do
  desc 'Simple deploy without migration'
  task :simple => :deploy

  desc ':deploy, :migrate, :restart'
  task :deploy_and_migrate => [:deploy, :migrate, 'knight:restart']
  desc ':deploy, :migrate, :restart'
  task :default => :deploy_and_migrate

  desc ':deploy, :migrate, :seed, :restart'
  task :deploy_and_seed => [:deploy, :migrate, :seed, 'knight:restart']

  desc 'Deploy to heroku'
  task :deploy do
    puts    'Deploying to production...'
    system  'git push heroku master'
  end

  desc 'Migrate the database'
  task :migrate do
    puts    'Migrating Database...'
    system  'heroku run rake db:migrate'
  end

  desc 'Migrate new seeds'
  task :seed do
    puts    'Migrating new Seeds...'
    system  'heroku run rake db:seed'
  end
end

##
#  Knight
#
namespace :knight do
  desc 'Restart processes'
  task :restart do
    puts    'Restarting Processes...'
    system  'heroku restart'
  end

  desc 'Perform serial Knight Update'
  task :update do
    puts 'Processing update Knight in production...'
    system 'heroku run rails runner KnightUpdater.update_knight_serial'
  end

  desc 'Clear away empty categories'
  task :clean do
    puts 'Cleaning Knight of empty categories...'
    system 'heroku run rails runner Category.clean'
  end

  desc 'Bust Caches'
  task :caches do
    puts 'Busting Caches...'
    system 'heroku run rails runner Repo.bust_caches'
    system 'heroku run rails runner Category.bust_caches'
  end
end
