require 'spec_helper'

feature "Sign in with Github" do
  let!(:repo) { Fabricate(:repo) }

  scenario "Guest signs in with Github" do
    visit login_path
    click_on "Login with Github"
    expect(current_path).to eq(repo_path(repo))
    expect(page).to have_content(/Thomas Klemm/)
  end
end
