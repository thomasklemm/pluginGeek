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

  describe "#staff" do
    it "returns true for staff members" do
      user.staff = true
      expect(user.staff).to be_true
    end

    it "returns false by default" do
      expect(user.staff).to be_false
    end
  end

  describe ".find_or_create_user_from_github" do
    let(:omniauth) { OmniAuth.config.mock_auth[:github] }

    context "with an already existing user" do
      let!(:existing_user)  { Fabricate(:user) }
      let!(:authentication) { Fabricate(:authentication, user: existing_user, provider: :github, uid: 1100176) }
      let(:user) { User.find_or_create_user_from_github(omniauth) }

      it "finds the user by the authentication" do
        expect { user }.to_not change { User.count }
        expect(user.authentications.first).to eq(authentication)
      end

      it "updates the user's fields from the auth hash" do
        info = omniauth.info
        raw_info = omniauth.extra.raw_info

        expect(user.login).to eq(info.nickname)
        expect(user.name).to  eq(info.name)
        expect(user.email).to eq(info.email)
        expect(user.avatar_url).to eq(info.image)
        expect(user.company).to    eq(raw_info.company)
        expect(user.location).to   eq(raw_info.location)
        expect(user.followers).to  eq(raw_info.followers)

        expect(user.login).to be_present
        expect(user.name).to  be_present
        expect(user.email).to be_present
        expect(user.avatar_url).to be_present
        expect(user.company).to    be_present
        expect(user.location).to   be_present
        expect(user.followers).to  be_present
      end

      it "returns the user" do
        expect(user).to be_a(User)
      end
    end

    context "with a new user" do
      let(:user) { User.find_or_create_user_from_github(omniauth) }

      it "assigns the user's fields from the auth hash" do
        info = omniauth.info
        raw_info = omniauth.extra.raw_info

        expect(user.login).to eq(info.nickname)
        expect(user.name).to  eq(info.name)
        expect(user.email).to eq(info.email)
        expect(user.avatar_url).to eq(info.image)
        expect(user.company).to    eq(raw_info.company)
        expect(user.location).to   eq(raw_info.location)
        expect(user.followers).to  eq(raw_info.followers)

        expect(user.login).to be_present
        expect(user.name).to  be_present
        expect(user.email).to be_present
        expect(user.avatar_url).to be_present
        expect(user.company).to    be_present
        expect(user.location).to   be_present
        expect(user.followers).to  be_present
      end

      it "saves the the new user in the database" do
        expect { user }.to change { User.count }.by(1)
        expect(user).to be_persisted
      end

      it "creates the authentication" do
        expect { user }.to change { Authentication.count }.by(1)
        expect(user.authentications).to be_present
        expect(user.authentications.first).to be_persisted
      end

      it "returns the user" do
        expect(user).to be_a(User)
      end
    end
  end
end
