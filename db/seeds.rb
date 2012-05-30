# ruby encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# Repos
repo_list = [
  ['rails/rails', 'web application framework, high-level web application framework'],
  ['sinatra/sinatra', 'web application framework, medium-level web application framework'],
  ['zurb/foundation', 'design framework'],
  ['twitter/bootstrap', 'design framework'],
  ['NoamB/sorcery', 'rails authentication, rails authorization'],
  ['plataformatec/devise', 'rails authentication, rails authorization'],
  ['rodreegez/powder', 'development server'],
  ['mbleigh/acts-as-taggable-on', 'rails tagging, active_record tagging'],
  ['bradphelan/rocket_tag', 'rails tagging, active_record tagging'],
  ['mperham/sidekiq', 'background jobs'],
  ['mperham/girl_friday', 'background jobs']
]

repo_list.each do |repo|
  Repo.create(full_name: repo[0], category_list: repo[1])
end

# Categories
category_list = [
  ['rails authentication', 'User Management for your Rails apps.'],
  ['design framework', 'Good foundation for your website styling.'],
  ['rails authorization', 'User Rights Management for your Rails apps.'],
  ['development server', 'Local Development Server with automatic reload capabilites. Speeds up development.'],
  ['rails tagging', 'Tagging functionality for your Rails apps.'],
  ['background jobs', 'Message queuing helps you allocating workload to seperate worker processes in the background. Used as synonyms: Background processing, message queues.'],
  ['active_record tagging', 'Tagging functionality for the ActiveRecord ORM (Rails Standard).']
]

category_list.each do |category|
  Category.create(name: category[0], description: category[1])
end

# Jobs
Repo.update_all_repos_from_github
Category.update