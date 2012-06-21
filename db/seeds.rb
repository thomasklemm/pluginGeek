# ruby encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
# Empty Items List:   {name: 'Subdomains', lang: 'Ruby/Design', repos: %w(RailsApps/rails3-subdomains), description: ''}
#
# Be sure to respect mass assignment protection!

# Build seeds
seeds = [
  {name: 'Web Application Framework', lang: 'Ruby', repos: %w(rails/rails sinatra/sinatra), description: 'Build web applications easily with style.'},
  {name: 'Design Framework', lang: 'Design', repos: %w(twitter/bootstrap zurb/foundation h5bp/html5-boilerplate necolas/normalize.css), description: 'Build well designed websites with ease. Design Frameworks like Twitter Bootstrap and Zurb Foundation include a grid system, pre-styled buttons and form, and many design elements that you can use out of the box to quickly get a great looking website up and running. Of course you can always customize them to the fullest extent.'},
  {name: 'Development Server', lang: 'Ruby', repos: %w(37signals/pow rodreegez/powder), description: 'Automatically run your apps on your local machine, and access them with special domains in your browser.'},
  {name: 'Object Tagging / Marking / Liking', lang: 'Ruby', repos: %w(mbleigh/acts-as-taggable-on bradphelan/rocket_tag schneems/Likeable chrome/markable), description: 'Tagging and marking for your ActiveRecord models.'},
  {name: 'Background Jobs', lang: 'Ruby', repos: %w(mperham/sidekiq mperham/girl_friday defunkt/resque collectiveidea/delayed_job ryandotsmith/queue_classic), description: 'Process worker tasks in the background.'},
  {name: 'Authentication', lang: 'Ruby', repos: %w(plataformatec/devise NoamB/sorcery thoughtbot/clearance intridea/omniauth), description: 'Authenticate your users.'},
  {name: 'Authorization', lang: 'Ruby', repos: %w(ryanb/cancan stffn/declarative_authorization kristianmandrup/cantango nathanl/authority james2m/canard mcrowe/roleable), description: 'Manage user roles and abilities. There are various concepts when it come to Authorization.'},
  {name: 'Email Preview', lang: 'Ruby', repos: %w(37signals/mail_view ryanb/letter_opener sj26/mailcatcher), description: 'Preview emails in the browser instead of sending them. Useful in development and for testing the design of emails and newsletters.'},
  {name: 'Project Generators / Templates', lang: 'Ruby', repos: %w(jeriko/app_drone RailsApps/rails_apps_composer RailsApps/rails3-application-templates), description: 'Get your project off the ground with ease.'},
  {name: 'Icon Fonts', lang: 'Design', repos: %w(FortAwesome/Font-Awesome pfefferle/openwebicons zurb/foundation-icons), description: 'Icon fonts are the new way to get icons on a website. Advantages over image files: Scalable to every size because they are vectorised; Most CSS3 Properties are available: Shadows, Borders etc. Color can be changed freely.'},
  {name: 'Styleguides', lang: 'Ruby', repos: %w(bbatsov/rails-style-guide bbatsov/ruby-style-guide copycopter/style-guide), description: 'Write maintainable ruby code.'},
  {name: 'Styleguides', lang: 'Design', repos: %w(necolas/idiomatic-css), description: 'Write consistent and maintainable view files. Book recommendation: The Rails View, Pragmatic Programmers.'},
  {name: 'Twitter API Clients', lang: 'Ruby', repos: %w(intridea/tweetstream jnunemaker/twitter sferik/t jugyo/earthquake marcel/twurl twitter/twitter-text-rb voloko/twitter-stream seejohnrun/console_tweet), description: 'API Wrappers for Twitter.'},
  {name: 'Rubies', lang: 'Ruby', repos: %w(ruby/ruby mruby/mruby jruby/jruby rubinius/rubinius), description: 'Ruby Implementations.'},
  {name: 'Source Code Management', lang: 'Ruby/JS', repos: %w(gitlabhq/gitlabhq), description: 'Version Control for your code.'},
  {name: 'Collaboration / Project Management',lang: 'Ruby/JS', repos: %w(teambox/teambox), description: 'Team collaboration.'},
  {name: 'Rails App Tutorials', lang: 'Ruby', repos: %w(RailsApps/rails3-bootstrap-devise-cancan sferik/sign-in-with-twitter RailsApps/rails-prelaunch-signup RailsApps/rails3-mongoid-omniauth RailsApps/rails3-mongoid-devise RailsApps/rails3-bootstrap-devise-cancan RailsApps/rails3-devise-rspec-cucumber RailsApps/rails3-subdomains), description: 'Example apps and tutorials.'},
  {name: 'Textmate and Sublime Text Snippets', lang: 'Ruby/JS/Design', repos: %w(devtellect/sublime-twitter-bootstrap-snippets), description: 'Code Editor snippets. Mostly Textmate and Sublime Text. You can generally use Textmate Plugins in Sublime Text 2.'},
  {name: 'Twitter Bootstrap for Rails', lang: 'Ruby/Design', repos: %w(mjbellantoni/formtastic-bootstrap rafaelfranca/simple_form-bootstrap sethvargo/bootstrap_forms seyhunak/twitter-bootstrap-rails metaskills/less-rails-bootstrap anjlab/bootstrap-rails yabawock/bootstrap-sass-rails xdite/bootstrap-helper yrgoldteeth/bootstrap-will_paginate decioferreira/bootstrap-generators pusewicz/twitter-bootstrap-markup-rails thomaspark/bootswatch anjlab/bootstrap-rails), description: 'Helpers for using Twitter Bootstrap with Rails.'},
  {name: 'Web Design Elements', lang: 'Design', repos: %w(todc/css3-google-buttons necolas/normalize.css necolas/css3-github-buttons michenriksen/css3buttons), description: 'Buttons, Form Styles, Cross-Browser Styles etc.'},
  {name: 'Subdomains', lang: 'Ruby', repos: %w(RailsApps/rails3-subdomains), description: 'Working with Subdomains got much easier in Rails 3.1+. Take a look at the Rails Guide "Rails Routing from the Outside in" (http://guides.rubyonrails.org/routing.html).'}
]

puts "Writing Seeds..."

# Enter or update seeds
seeds.each do |seed|

  # Create or update repos
  seed[:repos].each do |full_name|
    repo = Repo.find_or_initialize_by_full_name(full_name)

    # Assign multiple categories to a repo while seeding
    categories = []
    categories << repo.category_list
    categories << "#{ seed[:name] } (#{ seed[:lang] })"
    repo.category_list = categories.join(', ')

    repo.save
  end

  # Create or update categories
  category = Category.find_or_initialize_by_name("#{ seed[:name] } (#{ seed[:lang] })")
  category.description ||= seed[:description]
  category.language_list = seed[:lang].split('/').join(', ')
  category.save
end

puts "Running 'Updater.update_repos_from_github'."
Updater.update_repos_from_github

puts "Running 'Updater.update_categories_from_repos'."
Updater.update_categories_from_repos

puts 'Finished writing seeds successfully.'