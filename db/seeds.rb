# ruby encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
# Empty Items List: {name: '', group: '', repos: %w(RailsApps/rails3-subdomains), description: ''}
#
# Be sure to respect mass assignment protection!

# Build seeds
seeds = [
  {name: 'Web Application Framework', group: '', repos: %w(rails/rails sinatra/sinatra), description: 'Build web applications easily with style.'},
  {name: 'Design Framework', group: 'Web Design', repos: %w(twitter/bootstrap zurb/foundation h5bp/html5-boilerplate), description: 'Build great looking websites with ease.'},
  {name: 'Development Server', group: 'Development', repos: %w(37signals/pow rodreegez/powder), description: 'Automatically run your apps on your local machine, and access them with special domains in your browser.'},
  {name: 'Tagging', group: 'ActiveRecord', repos: %w(mbleigh/acts-as-taggable-on bradphelan/rocket_tag), description: 'Tagging and marking for your ActiveRecord models.'},
  {name: 'Background Jobs', group: '', repos: %w(mperham/sidekiq mperham/girl_friday defunkt/resque collectiveidea/delayed_job ryandotsmith/queue_classic), description: 'Process worker tasks in the background.'},
  {name: 'Authentication', group: 'User Management', repos: %w(plataformatec/devise NoamB/sorcery thoughtbot/clearance intridea/omniauth), description: 'Authenticate your users.'},
  {name: 'Authorization', group: 'User Management', repos: %w(ryanb/cancan stffn/declarative_authorization kristianmandrup/cantango nathanl/authority james2m/canard mcrowe/roleable), description: 'Manage user roles and abilities. There are various concepts when it come to Authorization.'},
  {name: 'Email Preview', group: 'ActionMailer', repos: %w(37signals/mail_view ryanb/letter_opener sj26/mailcatcher), description: 'Preview emails in the browser instead of sending them. Useful in development and for testing the design of emails and newsletters.'},
  {name: 'Project Generators / Templates', group: 'Rails', repos: %w(jeriko/app_drone RailsApps/rails_apps_composer RailsApps/rails3-application-templates), description: 'Get your project off the ground with ease.'},
  {name: 'Icon Fonts', group: 'Web Design', repos: %w(FortAwesome/Font-Awesome pfefferle/openwebicons zurb/foundation-icons), description: ''},
  {name: 'Styleguides', group: '', repos: %w(necolas/idiomatic-css bbatsov/rails-style-guide bbatsov/ruby-style-guide copycopter/style-guide), description: ''},
  {name: 'Twitter API Clients', group: 'API Wrappers', repos: %w(intridea/tweetstream jnunemaker/twitter sferik/t jugyo/earthquake marcel/twurl twitter/twitter-text-rb voloko/twitter-stream seejohnrun/console_tweet), description: ''},
  {name: 'Rubies', group: '', repos: %w(ruby/ruby mruby/mruby jruby/jruby rubinius/rubinius), description: ''},
  {name: 'Source Code Management', group: '', repos: %w(gitlabhq/gitlabhq), description: ''},
  {name: 'Collaboration / Project Management', group: '', repos: %w(teambox/teambox), description: ''},
  {name: 'Twitter Bootstrap Forms', group: 'Twitter Bootstrap', repos: %w(mjbellantoni/formtastic-bootstrap rafaelfranca/simple_form-bootstrap sethvargo/bootstrap_forms), description: ''},
  {name: 'Rails App Tutorials', group: 'Rails', repos: %w(RailsApps/rails3-bootstrap-devise-cancan sferik/sign-in-with-twitter RailsApps/rails-prelaunch-signup RailsApps/rails3-mongoid-omniauth RailsApps/rails3-mongoid-devise RailsApps/rails3-bootstrap-devise-cancan RailsApps/rails3-devise-rspec-cucumber RailsApps/rails3-subdomains), description: ''},
  {name: 'Textmate and Sublime Text Snippets', group: '', repos: %w(devtellect/sublime-twitter-bootstrap-snippets), description: ''},
  {name: 'Twitter Bootstrap for Rails', group: 'Web Design', repos: %w(seyhunak/twitter-bootstrap-rails metaskills/less-rails-bootstrap anjlab/bootstrap-rails yabawock/bootstrap-sass-rails xdite/bootstrap-helper yrgoldteeth/bootstrap-will_paginate decioferreira/bootstrap-generators pusewicz/twitter-bootstrap-markup-rails thomaspark/bootswatch anjlab/bootstrap-rails), description: ''},
  {name: 'Web Design Elements', group: 'Web Design', repos: %w(todc/css3-google-buttons necolas/normalize.css necolas/css3-github-buttons michenriksen/css3buttons), description: ''},
  {name: 'Subdomains', group: 'Rails', repos: %w(RailsApps/rails3-subdomains), description: ''}
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
end

puts "Running 'Updater.update_repos_from_github'."
Updater.update_repos_from_github

puts "Running 'Updater.update_categories_from_repos'."
Updater.update_categories_from_repos

puts 'Finished writing or updating seeds successfully.'