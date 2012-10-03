# Deployment Rake Tasks
desc 'Simple deploy to production (no migrations)'
task :deploy => 'deploy:production'

namespace :deploy do
  ##
  # PRODUCTION
  desc 'Deploy to PRODUCTION'
  task :production do
    puts    'Pushing to Github...'
    system  'git push origin master'
    puts    'Pushed to Github'

    puts    'Deploying to production...'
    system  'git push production master'
    puts    'Deployed to production'
  end

  desc 'Migrate production databases'
  task 'production:migrate' do
    puts    'Migrating PRODUCTION databases...'
    system  'heroku run rake db:migrate --app knightio'
    puts    'Migrated production databases'

    puts    'Restarting processes'
    system  'heroku restart --app knightio'
  end

  ##
  # STAGING
  desc 'Deploy to STAGING'
  task :staging do
    puts    'Deploying to staging...'
    system  'git push staging staging'
    puts    'Deployed to staging'
  end

  desc 'Migrate STAGING databases'
  task 'production:migrate' do
    puts    'Migrating STAGING databases...'
    system  'heroku run rake db:migrate --app knightio-staging'
    puts    'Migrated staging databases'

    puts    'Restarting processes'
    system  'heroku restart --app knightio-staging'
  end
end
