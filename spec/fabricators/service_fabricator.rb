# == Schema Information
#
# Table name: services
#
#  created_at  :datetime         not null
#  description :text
#  display_url :text
#  id          :integer          not null, primary key
#  name        :text
#  target_url  :text
#  updated_at  :datetime         not null
#

Fabricator(:service) do
  name        "service_name"
  display_url "service_display_url"
  target_url  "service_target_url"
  description "service_description"
end
