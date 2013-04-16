require 'spec_helper'

describe "Github login" do
  # Create a language to circumvent inifite redirect error
  before { Fabricate(:language, name: 'Ruby') }

  context "github user authorizes app" do
    it "creates and logs in the user" do
      visit root_path

      click_on "Login"
      expect(current_path).to eq(login_path)

      click_on "Login with Github"
      expect(current_path).to eq(root_path)
      expect(page).to have_content(/Thomas Klemm/)
    end
  end

  context "github user does not authorize app" do
    it "fails to authenticate" do
      OmniAuth.config.mock_auth[:github] = :access_denied

      visit login_path
      click_on "Login with Github"

      expect(current_path).to eq(root_path)
      expect(page).to have_content(/Authenticating with Github failed/)
      expect(page).to have_no_content(/Thomas Klemm/)
    end
  end
end
