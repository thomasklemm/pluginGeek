# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
# 	Blueprint: Repo.create(full_name: '', category_list: '')

Repo.create(full_name: "rails/rails", category_list: "web application framework")
Repo.create(full_name: 'sinatra/sinatra', category_list: 'web application framework')
Repo.create(full_name: 'zurb/foundation', category_list: 'design framework')
Repo.create(full_name: 'twitter/bootstrap', category_list: 'design framework')
Repo.create(full_name: 'NoamB/sorcery', category_list: 'rails authentication, rails authorization')
Repo.create(full_name: 'plataformatec/devise', category_list: 'rails authentication, rails authorization')
Repo.create(full_name: 'rodreegez/powder', category_list: 'development server')
Repo.create(full_name: 'mbleigh/acts-as-taggable-on', category_list: 'rails tagging, active_record tagging')
Repo.create(full_name: 'bradphelan/rocket_tag', category_list: 'rails tagging, active_record tagging')
Repo.create(full_name: 'mperham/sidekiq', category_list: 'background jobs')
Repo.create(full_name: 'mperham/girl_friday', category_list: 'background jobs')
