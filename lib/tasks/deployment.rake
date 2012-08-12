namespace :heroku do
  default: :deploy

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

  task :deploy_and_migrate do
    Rake::Task['heroku:deploy'].invoke
    Rake::Task['heroku:migrate'].invoke
    Rake::Task['heroku:restart'].invoke
  end

  task :deploy_and_seed do
    Rake::Task['heroku:deploy'].invoke
    Rake::Task['heroku:migrate'].invoke
    Rake::Task['heroku:seed'].invoke
    Rake::Task['heroku:restart'].invoke
  end
end