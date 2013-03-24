# == Schema Information
#
# Table name: users
#
#  admin               :boolean          default(FALSE)
#  avatar_url          :text
#  company             :text
#  created_at          :datetime         not null
#  current_sign_in_at  :datetime
#  current_sign_in_ip  :string(255)
#  email               :text
#  followers           :integer
#  id                  :integer          not null, primary key
#  last_sign_in_at     :datetime
#  last_sign_in_ip     :string(255)
#  location            :text
#  login               :text             not null
#  name                :text
#  remember_created_at :datetime
#  remember_token      :text
#  sign_in_count       :integer          default(0)
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_users_on_login           (login) UNIQUE
#  index_users_on_remember_token  (remember_token)
#

Fabricator(:user) do
  login { sequence(:login) { |n| "github_user_#{ n }" } }
end
