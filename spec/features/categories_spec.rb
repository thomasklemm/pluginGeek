require 'spec_helper'

include Warden::Test::Helpers
Warden.test_mode!

def sign_in(user)
  login_as(user, scope: :user)
end

def sign_out
  logout(:user)
end

feature "Categories#index" do
  let(:user)  { Fabricate(:user) }
  let(:staff) { Fabricate(:user, staff: true) }

  let(:language) { Fabricate(:language, name: 'Ruby') }
  let(:category) { Fabricate(:category) }
  let(:repo)     { Fabricate(:repo) }

  shared_examples "list categories" do
    background do
      category.languages << language
      category.repos << repo
      category.save
    end

    scenario "list categories" do
      visit categories_path(language.slug)
      expect(current_path).to eq("/#{language.slug}")

      expect(page).to have_content(category.full_name)
      expect(page).to have_content(repo.full_name)
      expect(page).to have_content(language.name)
    end
  end

  describe "staff access" do
    before { sign_in staff }
    include_examples "list categories"
  end

  describe "user access" do
    before { sign_in user }
    include_examples "list categories"
  end

  describe "guest access" do
    include_examples "list categories"
  end
end

feature "Categories#show" do
  let(:user)  { Fabricate(:user) }
  let(:staff) { Fabricate(:user, staff: true) }

  let(:language) { Fabricate(:language, name: 'Ruby') }
  let(:category) { Fabricate(:category) }
  let(:repo)     { Fabricate(:repo) }
  let(:link)     { Fabricate(:link) }
  let(:link_via_repo)    { Fabricate(:link) }
  let(:similar_category) { Fabricate(:category) }

  shared_examples "render category" do
    background do
      category.languages << language
      category.repos << repo
      category.related_categories << similar_category
      category.links << link
      repo.links << link_via_repo
    end

    scenario "render category" do
      path = category_path(category)
      visit path
      expect(current_path).to eq(path)

      expect(page).to have_content(category.full_name)
      expect(page).to have_content(language.name)

      expect(page).to have_content(repo.full_name)
      expect(page).to have_content(similar_category.full_name)

      expect(page).to have_content(link.title)
      expect(page).to have_content(link_via_repo.title)
    end
  end

  describe "staff access" do
    before { sign_in staff }
    include_examples "render category"
  end

  describe "user access" do
    before { sign_in user }
    include_examples "render category"
  end

  describe "guest access" do
    include_examples "render category"
  end
end

feature "Categories#edit and categories#update" do
  let(:user)  { Fabricate(:user) }
  let(:staff) { Fabricate(:user, staff: true) }

  let(:language) { Fabricate(:language, name: 'Ruby') }
  let(:category) { Fabricate(:category) }
  let(:repo)     { Fabricate(:repo) }
  let(:link)     { Fabricate(:link) }
  let(:link_via_repo)    { Fabricate(:link) }
  let(:similar_category) { Fabricate(:category) }

  background do
    category.languages << language
    category.repos << repo
    category.related_categories << similar_category
    category.links << link
    repo.links << link_via_repo
  end

  shared_examples "render form" do
    scenario "render form" do
      path = edit_category_path(category)
      visit path
      expect(current_path).to eq(path)
    end
  end

  describe "staff access" do
    before { sign_in staff }
    include_examples "render form"
  end

  describe "user access" do
    before { sign_in user }
    include_examples "render form"
  end

  describe "guest access" do
    scenario "forbidden request" do
      visit edit_category_path(category)

      expect(current_path).to eq(login_path)
      expect(page).to have_content(/login/)
    end
  end
end
