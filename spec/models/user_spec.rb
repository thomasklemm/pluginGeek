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
