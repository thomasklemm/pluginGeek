require 'spec_helper'

feature "Robots" do
  context "canonical host" do
    scenario "allow robots to index the site" do
      Capybara.app_host = 'http://www.plugingeek.com'
      visit '/robots.txt'
      Capybara.app_host = nil

      expect(page).to have_content('# ALLOW ROBOTS')
      expect(page).to have_content('User-agent: *')
      expect(page).to have_content('Disallow:')
      expect(page).to have_no_content('Disallow: /')
    end
  end

  context "non-canonical host" do
    scenario "deny robots to index the site" do
      visit '/robots.txt'

      expect(page).to have_content('# DISALLOW ROBOTS')
      expect(page).to have_content('User-agent: *')
      expect(page).to have_content('Disallow: /')
    end
  end
end
