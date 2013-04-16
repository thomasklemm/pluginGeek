require 'spec_helper'

# TODO: Extract
include Warden::Test::Helpers
Warden.test_mode!

def sign_in(user)
  login_as(user, scope: :user)
end

def sign_out
  logout(:user)
end

shared_context "category" do
  let!(:language) { Fabricate(:language, name: "Ruby") }
  let!(:category) { Fabricate(:category, languages: [language], repos: [repo]) }
  let!(:repo)     { Fabricate(:repo) }

  let(:user)  { Fabricate(:user) }
  let(:staff) { Fabricate(:user, staff: true) }
end

describe Category, "list categories" do
  include_context "category"

  it "lists categories" do
    visit categories_path(language.slug)
    expect(current_path).to eq("/#{ language.slug }")

    expect(page).to have_content(category.full_name)
    expect(page).to have_content(repo.name)
    expect(page).to have_content(language.name)
  end
end

describe Category, "show category" do
  include_context "category"
  let!(:link)     { Fabricate(:link, categories: [category]) }
  let!(:link_via_repo)    { Fabricate(:link, repos: [repo]) }
  let!(:similar_category) { Fabricate(:category, related_categories: [category]) }

  it "shows the category" do
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

describe Category, "edit and update category" do
  include_context "category"

  it "updates the category" do
    sign_in user

    visit category_path(category)
    click_on "Edit"
    expect(current_path).to eq(edit_category_path(category))

    fill_in "describe", with: "some new description"
    click_on "Update"

    expect(current_path).to eq(category_path(category))
    expect(page).to have_content(/Category has been updated/)
    expect(page).to have_content("some new description")
  end
end

describe Category, "refresh category" do
  include_context "category"

  it "refreshes the category" do
    sign_in staff

    visit category_path(category)
    click_on "Refresh"

    expect(current_path).to eq(category_path(category))
    expect(page).to have_content(/Category has been refreshed/)
  end
end

describe Category, "destroy category" do
  include_context "category"

  it "destroys the category" do
    sign_in staff

    visit edit_category_path(category)
    expect(current_path).to eq(edit_category_path(category))

    click_on "Destroy"

    expect(current_path).to eq(root_path)
    expect(page).to have_content(/Category has been destroyed/)
  end
end
