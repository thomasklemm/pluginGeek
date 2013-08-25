class CategoryRelationship < ActiveRecord::Base
  belongs_to :category,
    touch: true
  belongs_to :other_category,
    class_name: 'Category',
    touch: true

  validates :category,
            :other_category,
            presence: true
end
