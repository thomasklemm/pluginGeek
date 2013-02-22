##
# Deployment Rake Tasks
#
# For all other tasks use the executables provided by Thoughtbot
# Source: https://github.com/thoughtbot/dotfiles/blob/master/bin/production
#
# Interact with the production environment on Heroku.
#
# rake production:deploy
# production backup
# production console
# production migrate
# production tail
#
# The script also acts as a pass-through, so you can do anything with it that
# you can do with `heroku ______ -r production`:
#
# production open
# watch production ps

# Production app
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
end

# Staging app
namespace :staging do
  desc 'Deploy to STAGING'
  task :deploy do
    puts    'Pushing to development branch on Github...'
    system  'git push origin develop'
    puts    'Pushed to Github'

    puts    'Deploying to staging...'
    system  'git push staging develop:master'
    puts    'Deployed to staging'
  end
end

