class Categorization < ActiveRecord::Base
  belongs_to :repo,
    touch: true
  belongs_to :category,
    touch: true
end
