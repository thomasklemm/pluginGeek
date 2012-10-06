##
# Deployment Rake Tasks

##
# STAGING
namespace :staging do
  desc 'Deploy to STAGING'
  task :deploy do
    puts    'Deploying to staging...'
    system  'git push staging develop:master'
    puts    'Deployed to staging'
  end

  desc 'Migrate STAGING database'
  task :migrate_db do
    puts    'Migrating STAGING database...'
    system  'heroku run rake db:migrate --remote staging'
    puts    'Migrated staging database'

    system  'heroku restart --remote staging'
  end

  desc 'Transfer production database to staging'
  task :transfer_db do
    # Expire oldest manual backup
    puts    'Expiring oldest manual backup...'
    system  'heroku pgbackups:capture --expire --remote production'

    # Capture manual database backup in production
    puts    'Capturing manual database backup in production...'
    system  'heroku pgbackups:capture --remote production'
    puts    'Captured manual database backup in production'

    # Restore most current backup to database in staging
    puts    'Transfering production database to STAGING...'
    system  'heroku pgbackups:restore DATABASE `heroku pgbackups:url --remote production` --remote staging --confirm knightio-staging'
    puts    'Transferred production database to staging'

    system  'heroku restart --remote staging'
  end

  desc 'Open a console to staging app'
  task :console do
    puts   'Open a console to STAGING app'
    system 'heroku run console --remote staging'
  end
end

desc 'Deploy to STAGING'
task :deploy => 'staging:deploy'

##
# PRODUCTION
namespace :production do
  desc 'Deploy to PRODUCTION'
  task :deploy do
    puts    'Pushing to Github...'
    system  'git push origin master'
    puts    'Pushed to Github'

    puts    'Deploying to production...'
    system  'git push production master'
    puts    'Deployed to production'
  end

  desc 'Migrate production database'
  task :migrate_db do
    puts    'Migrating PRODUCTION database...'
    system  'heroku run rake db:migrate --remote production'
    puts    'Migrated production database'

    puts    'Restarting processes'
    system  'heroku restart --remote production'
  end

  desc 'Open a console to production app'
  task :console do
    puts   'Open a console to PRODUCTION app'
    system 'heroku run console --remote production'
  end

  desc 'Pull the production DB to the local env'
  task :pull_db do
    puts   'Pulling PRODUCTION db to local...'
    system 'heroku db:pull --app knightio --confirm knightio'
    puts   'PUlled production db to local'
  end
end
