# Deployment Rake Tasks

##
#  Deploy
#
desc 'Deploy, migrate and restart processes'
task :deploy => 'deploy:deploy_and_migrate'

namespace :knight do
  desc 'Simple deploy without migration'
  task :simple => :deploy

  desc ':deploy, :migrate, :restart'
  task :deploy_and_migrate => [:deploy, :migrate, :restart]

  desc ':deploy, :migrate, :restart'
  task :default => :deploy_and_migrate

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

  desc 'Restart processes'
  task :restart do
    puts    'Restarting Processes...'
    system  'heroku restart'
  end

  desc 'Perform serial Knight Update'
  task :update_knight do
    puts 'Processing update Knight in production...'
    system 'heroku run rails runner KnightUpdater.update_knight_serial'
  end

  desc 'Clear away empty categories'
  task :clean_empty_categories do
    puts 'Cleaning Knight of empty categories...'
    system 'heroku run rails runner Category.clean'
  end

  desc 'Bust Caches'
  task :bust_caches do
    puts 'Busting Caches...'
    system 'heroku run rails runner Repo.bust_caches'
    system 'heroku run rails runner Category.bust_caches'
  end
end
