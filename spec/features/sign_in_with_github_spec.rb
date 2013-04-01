require 'spec_helper'

feature "Sign in with Github" do
  before do
    Fabricate(:language, name: 'Ruby')
  end

  scenario "guest signs in with Github" do
    visit login_path
    click_on "Login with Github"

    expect(current_path).to eq(root_path)
    expect(page).to have_content(/Thomas Klemm/)
  end
end
