# == Schema Information
#
# Table name: category_relationships
#
#  category_id       :integer
#  created_at        :datetime         not null
#  id                :integer          not null, primary key
#  other_category_id :integer
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_category_relationships_on_category_id        (category_id)
#  index_category_relationships_on_other_category_id  (other_category_id)
#

class CategoryRelationship < ActiveRecord::Base
  belongs_to :category,
    touch: true
  belongs_to :other_category,
    class_name: 'Category',
    touch: true

  validates :category, :other_category, presence: true
end
