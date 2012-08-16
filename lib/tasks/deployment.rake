# Deployment Rake Tasks

namespace :heroku do
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

  desc 'Clean Assets'
  task 'assets:clean' do
    puts    'Cleaning Assets...'
    system  'heroku run rails runner Rails.cache.clear'
  end

  desc 'Bust Caches'
  task :caches do
    puts 'Busting Caches...'
    system 'heroku run rails runner Repo.bust_caches && Category.bust_caches '
  end

  desc ':deploy, :migrate, :restart'
  task :deploy_and_migrate => [:deploy, :migrate, :restart]

  desc ':deploy, :migrate, :seed, :restart'
  task :deploy_and_seed => [:deploy, :migrate, :seed, :restart]
end

desc 'Deploy, migrate & restart'
task :deploy => ['heroku:deploy_and_migrate']

desc 'Simple deploy without migration'
task 'deploy:simple' => ['heroku:deploy']
