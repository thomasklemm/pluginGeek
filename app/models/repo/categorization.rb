class Repo::Categorization < ActiveRecord::Base
  belongs_to :repo
  belongs_to :category, counter_cache: :repos_count
end
