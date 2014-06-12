require 'spec_helper'

feature "Github login" do
  context "github user authorizes app" do
    it "creates and logs in the user" do
      visit root_path

      click_on "Login"
      expect(current_path).to eq(login_path)

      click_on "Login with GitHub"
      expect(current_path).to eq(root_path)
      expect(page).to have_content(/Thomas Klemm/)
      expect(page).to have_content(/Logout/)
    end
  end

  context "github user does not authorize app" do
    it "fails to authenticate" do
      OmniAuth.config.mock_auth[:github] = :access_denied

      visit login_path
      click_on "Login with GitHub"

      expect(current_path).to eq(root_path)
      expect(page).to have_content(/Authenticating with Github failed/)
      expect(page).to have_content(/Login/)
    end
  end
end
