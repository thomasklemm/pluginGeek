# ruby encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
#   Copyable Item: ['', ''],


# Repos
repo_list = [
  ['rails/rails', 'web application framework'],
  ['sinatra/sinatra', 'web application framework'],
  ['zurb/foundation', 'design framework'],
  ['twitter/bootstrap', 'design framework'],
  ['37signals/pow', 'development server'],
  ['rodreegez/powder', 'development server'],
  ['mbleigh/acts-as-taggable-on', 'tagging'],
  ['bradphelan/rocket_tag', 'tagging'],
  ['chrome/markable', 'tagging'],
  ['mperham/sidekiq', 'background jobs'],
  ['mperham/girl_friday', 'background jobs'],
  ['defunkt/resque', 'background jobs'],
  ['collectiveidea/delayed_job', 'background jobs'],
  ['ryandotsmith/queue_classic', 'background jobs'],
  ['NoamB/sorcery', 'user management: authentication'],
  ['plataformatec/devise', 'user management: authentication'],
  ['thoughtbot/clearance', 'user management: authentication'],
  ['intridea/omniauth', 'user management: authentication'],
  ['ryanb/cancan', 'user management: authorization'],
  ['stffn/declarative_authorization', 'user management: authorization'],
  ['kristianmandrup/cantango', 'user management: authorization'],
  ['nathanl/authority', 'user management: authorization'],
  ['james2m/canard', 'user management: authorization'],
  ['mcrowe/roleable', 'user management: authorization'],
  ['37signals/mail_view', 'email: preview emails'],
  ['sj26/mailcatcher', 'email: preview emails']
  ['ryanb/letter_opener', 'email: preview emails'],
  ['jeriko/app_drone', 'rails: project generators and templates'],
  ['RailsApps/rails_apps_composer', 'rails: project generators and templates'],
  ['RailsApps/rails3-application-templates', 'rails: project generators and templates']
]

repo_list.each do |repo|
  Repo.create(full_name: repo[0], category_list: repo[1])
end

# Categories
category_list = [
  ['web application framework', 'Build web applications with style.'],
  ['user management: authentication', 'User Authentication Plugins, that let you manage your users and handle signing in via Oauth Services (Twitter, Facebook, Github & more). There\'s a good railscasts that shows how an authentication solution can work.'],
  ['user management: authorization', 'Manage User Rights, User Roles & Abilities.'],
  ['design framework', 'Good foundation for your website styling.'],
  ['development server', 'Local Development Server with automatic reload capabilites. Speeds up your development.'],
  ['tagging', 'Tagging functionality for your ActiveRecord Models.'],
  ['background jobs', 'Message queuing helps you allocating workload to seperate worker processes in the background. Used as synonyms: Background processing, message queues.'],
  ['email: preview emails', 'Preview emails in development, e.g. in the browser, instead of sending them.'],
  ['rails: project generators and templates', 'Get projects started. Helps getting up and running quickly, automating configuration.']
]

category_list.each do |category|
  Category.create(name: category[0], description: category[1])
end

# Run Jobs
Repo.update_all_repos_from_github
Category.update