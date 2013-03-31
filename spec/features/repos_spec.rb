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
