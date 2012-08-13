Rake::Task['assets:precompile'].clear
namespace :assets do
  task :precompile do
    puts '* rake assets:precompile has been disabled (lib/tasks/disable_precompile.rake)'
  end
end
# Source: http://blog.arvidandersson.se/2011/10/03/how-to-do-the-asset-serving-dance-on-heroku-cedar-with-rails-3-1