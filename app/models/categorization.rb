class Categorization < ActiveRecord::Base
  belongs_to :repo
  belongs_to :category
end
