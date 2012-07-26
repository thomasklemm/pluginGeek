# == Schema Information
#
# Table name: users
#
#  id                           :integer          not null, primary key
#  login                        :string(255)      not null
#  email                        :string(255)
#  name                         :string(255)
#  avatar_url                   :string(255)
#  github_url                   :string(255)
#  location                     :string(255)
#  company                      :string(255)
#  followers                    :integer
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  remember_me_token            :string(255)
#  remember_me_token_expires_at :datetime
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
