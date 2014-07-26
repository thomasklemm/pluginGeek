require 'spec_helper'

feature 'Github login' do
  context 'github user authorizes app' do
    it 'creates and logs in the user' do
      ensure_on root_path

      click_on 'Login'
      expect(current_path).to eq(login_path)

      click_on 'Login with GitHub'
      expect(current_path).to eq(root_path)
      expect(page).to have_content(/Hi, thomasklemm/)
      expect(page).to have_content(/Logout/)
    end
  end

  context 'github user does not authorize app' do
    it 'fails to authenticate' do
      OmniAuth.config.mock_auth[:github] = :access_denied

      ensure_on login_path
      click_on 'Login with GitHub'

      expect(current_path).to eq(root_path)
      expect(page).to have_content(/Authenticating with Github failed/)
      expect(page).not_to have_content(/Logout/)
    end
  end

  it 'redirects a user to the last stored location'
end
