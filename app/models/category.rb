class Category < ActiveRecord::Base
  attr_accessible :description, :name, :popular_repos
end
