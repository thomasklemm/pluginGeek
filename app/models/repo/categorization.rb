class Repo::Categorization < ActiveRecord::Base
  self.table_name = 'categorizations'

  belongs_to :repo
  belongs_to :category, counter_cache: :repos_count
end
