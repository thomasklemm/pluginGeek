class AdCategorization < ActiveRecord::Base
  belongs_to :category
  belongs_to :ad
end
