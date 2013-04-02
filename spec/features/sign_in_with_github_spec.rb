require 'spec_helper'

feature "Sign in with Github" do
  before do
    Fabricate(:language, name: 'Ruby')
  end

  scenario "guest grants access" do
    visit login_path
    click_on "Login with Github"

    expect(current_path).to eq(root_path)
    expect(page).to have_content(/Thomas Klemm/)
  end

  scenario "guest denies access" do
    OmniAuth.config.mock_auth[:github] = :access_denied

    visit login_path
    click_on "Login with Github"

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Authenticating with Github failed.")
  end
end
