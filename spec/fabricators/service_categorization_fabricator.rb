# == Schema Information
#
# Table name: service_categorizations
#
#  category_id :integer
#  created_at  :datetime         not null
#  id          :integer          not null, primary key
#  service_id  :integer
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_service_categorizations_on_category_id  (category_id)
#  index_service_categorizations_on_service_id   (service_id)
#

Fabricator(:service_categorization) do
  service
  category
end
