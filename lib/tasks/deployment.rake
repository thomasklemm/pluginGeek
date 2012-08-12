task :deploy do
  puts    'Deploying to production...'
  system  'git push heroku master'

  puts    'Migrating Database'
  system  'heroku run rake db:migrate'

  puts    'Migrating new Seeds'
  system  'heroku run rake db:seed'

  puts    'Restarting Processes'
  system  'heroku restart'
end