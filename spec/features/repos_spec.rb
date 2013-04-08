require 'spec_helper'

include Warden::Test::Helpers
Warden.test_mode!

def sign_in(user)
  login_as(user, scope: :user)
end

def sign_out
  logout(:user)
end

feature "Repos#show" do
  let(:user)  { Fabricate(:user) }
  let(:staff) { Fabricate(:user, staff: true) }

  let(:language) { Fabricate(:language, name: 'Ruby') }
  let(:category) { Fabricate(:category) }
  let(:repo)     { Fabricate(:repo) }
  let(:parent)   { Fabricate(:repo) }
  let(:child)    { Fabricate(:repo) }
  let(:link)     { Fabricate(:link) }

  shared_examples "render repo" do
    background do
      category.languages << language
      repo.categories << category
      repo.links << link

      repo.children << child
      repo.parents << parent
    end

    scenario "render repo" do
      path = repo_path(repo)
      visit path
      expect(current_path).to eq(path)

      expect(page).to have_content(repo.full_name)
      expect(page).to have_content(repo.stars)

      expect(page).to have_content(category.full_name)
      expect(page).to have_content(language.name)

      expect(page).to have_content(parent.full_name)
      expect(page).to have_content(child.full_name)

      expect(page).to have_content(link.title)
    end
  end

  describe "staff access" do
    before { sign_in staff }
    include_examples "render repo"
  end

  describe "user access" do
    before { sign_in user }
    include_examples "render repo"
  end

  describe "guest access" do
    include_examples "render repo"
  end
end

feature "Refresh repo" do
  let(:repo) { Fabricate(:repo, full_name: 'rails/rails') }
  let(:staff) { Fabricate(:user, staff: true) }
  before { sign_in staff }

  scenario "update repo from github with click on refresh" do
    VCR.use_cassette('features/repos/refresh', record: :once) do
      visit repo_path(repo)
      click_on "Refresh"

      expect(current_path).to eq(repo_path(repo))
      expect(page).to have_content(/Repo has been refreshed/)
      expect(page).to have_content('Ruby on Rails')
    end
  end
end
