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

Fabricator(:category_relationship) do
  category
  other_category { Fabricate(:category) }
end
