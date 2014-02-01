class CategoryRelationship < ActiveRecord::Base
  belongs_to :category
  belongs_to :other_category, class_name: 'Category'
end
