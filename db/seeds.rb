# ruby encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
# Empty Items List: {name: '', group: '', repos: %w(), description: ''}
#
# Be sure to respect mass assignment protection!

# Build seeds
seeds = [
  {name: 'Web Application Framework', group: '', repos: %w(rails/rails sinatra/sinatra), description: 'Build web applications easily with style.'},
  {name: 'Design Framework', group: '', repos: %w(twitter/bootstrap zurb/foundation), description: 'Build great looking websites with ease.'},
  {name: 'Development Server', group: 'Development', repos: %w(37signals/pow rodreegez/powder), description: 'Automatically run your apps on your local machine, and access them with special domains in your browser.'},
  {name: 'Tagging', group: 'ActiveRecord', repos: %w(mbleigh/acts-as-taggable-on bradphelan/rocket_tag), description: 'Tagging and marking for your ActiveRecord models.'},
  {name: 'Background Jobs', group: '', repos: %w(mperham/sidekiq mperham/girl_friday defunkt/resque collectiveidea/delayed_job ryandotsmith/queue_classic), description: 'Process worker tasks in the background.'},
  {name: 'Authentication', group: 'User Management', repos: %w(plataformatec/devise NoamB/sorcery thoughtbot/clearance intridea/omniauth), description: 'Authenticate your users.'},
  {name: 'Authorization', group: 'User Management', repos: %w(ryanb/cancan stffn/declarative_authorization kristianmandrup/cantango nathanl/authority james2m/canard mcrowe/roleable), description: 'Manage user roles and abilities. There are various concepts when it come to Authorization.'},
  {name: 'Email Preview', group: 'ActionMailer', repos: %w(37signals/mail_view ryanb/letter_opener sj26/mailcatcher), description: 'Preview emails in the browser instead of sending them. Useful in development and for testing the design of emails and newsletters.'},
  {name: 'Project Generators / Templates', group: 'Rails', repos: %w(jeriko/app_drone RailsApps/rails_apps_composer RailsApps/rails3-application-templates), description: 'Get your project off the ground with ease.'}
]

# Enter or update seeds
seeds.each do |seed|
  # Enter repos
  seed[:repos].each do |full_name|
    repo = Repo.find_or_initialize_by_full_name(full_name)
    categories = []
    categories << repo.category_list
    categories << seed[:name]
    repo.category_list = categories.join(', ')
    repo.save
  end

  # Enter category description
  category = Category.find_or_initialize_by_name(seed[:name])
  category.description = seed[:description]
  category.save
  category.reload
  puts category.inspect
end

puts "Running 'Updater.update_repos_from_github'."
Updater.update_repos_from_github

puts "Running 'Updater.update_categories_from_repos'."
Updater.update_categories_from_repos

puts 'Finished writing or updating seeds successfully.'