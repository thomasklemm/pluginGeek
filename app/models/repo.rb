class Repo < ActiveRecord::Base
  attr_accessible :description, :forks, :name, :owner, :url_github, :url_homepage, :watchers
end
