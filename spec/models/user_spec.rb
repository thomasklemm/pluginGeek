# == Schema Information
#
# Table name: users
#
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
#  staff               :boolean          default(FALSE)
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_users_on_login           (login) UNIQUE
#  index_users_on_remember_token  (remember_token)
#

require 'spec_helper'

describe User do
  subject(:user) { Fabricate.build(:user) }
  it { should be_valid }

  it { should validate_presence_of(:login) }
  it { should validate_uniqueness_of(:login) }

  it { should have_many(:authentications).dependent(:destroy) }

  describe ".find_or_create_user_from_github(omniauth)" do
    context "with an already existing user" do
      it "finds the user by the authentication"
      it "updates the user's fields from Github"
      it "returns the user"
    end

    context "with a new user" do
      it "creates the new user"
      it "creates the authentication"
      it "returns the user"
    end
  end
end
