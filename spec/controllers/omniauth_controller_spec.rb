require 'spec_helper'

describe OmniauthController, "#github" do
  before do
    request.env["devise.mapping"] = Devise.mappings[:user]
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
  end

  context "new user" do
    before { get :github }
    let(:user) { assigns(:user) }

    it { should redirect_to(root_path) }
    it { should set_the_flash.to(/Thomas Klemm/) }

    it "saves the user in the database" do
      expect(user).to be_persisted
    end

    it "signs the user in" do
      expect(controller.current_user).to eq(user)
    end

    it "creates a remember token for the user to keep him signed in" do
      expect(user.remember_token).to be_present
    end
  end

  context "returning user" do
    before do
      user = Fabricate.build(:user)
      User.expects(:find_or_create_user_from_github).returns(user)

      get :github
    end

    it { should redirect_to(root_path) }
    it { should set_the_flash.to(/failed/) }
  end
end
