# Deployment Rake Tasks

namespace :heroku do
  task :deploy do
    puts    'Deploying to production...'
    system  'git push heroku master'
  end

  task :migrate do
    puts    'Migrating Database'
    system  'heroku run rake db:migrate'
  end

  task :seed do
    puts    'Migrating new Seeds'
    system  'heroku run rake db:seed'
  end

  task :restart do
    puts    'Restarting Processes'
    system  'heroku restart'
  end

  task :deploy_and_migrate => [:deploy, :migrate, :restart]

  task :deploy_and_seed => ['heroku:deploy', 'heroku:migrate', 'heroku:seed', 'heroku:restart']
end

task :heroku => ['heroku:deploy_and_migrate']
task :deploy => :heroku
