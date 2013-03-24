# == Schema Information
#
# Table name: authentications
#
#  created_at :datetime         not null
#  id         :integer          not null, primary key
#  provider   :text             not null
#  uid        :text             not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_authentications_on_user_id  (user_id)
#

Fabricator(:authentication) do
  user
  provider "github"
  uid      "github_user_id"
end
