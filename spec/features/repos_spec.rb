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

shared_context "repo features" do
  let!(:language) { Fabricate(:language, name: "Ruby") }
  let!(:category) { Fabricate(:category) }
  let!(:repo)     { Fabricate(:repo, full_name: 'rails/rails', stars: 42) }

  let(:user)  { Fabricate(:user) }
  let(:staff) { Fabricate(:user, staff: true) }

  before do
    category.languages |= [language]
    category.repos |= [repo]
    category.save
  end
end

describe Repo, "show repo" do
  include_context "repo features"
  let!(:parent)   { Fabricate(:repo) }
  let!(:child)    { Fabricate(:repo) }
  let!(:link)     { Fabricate(:link) }

  before do
    parent.children |= [repo]
    child.parents |= [repo]
    link.repos |= [repo]
  end

  it "shows the repo" do
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

describe Repo, "edit and update repo" do
  include_context "repo features"
  let(:parent)   { Fabricate(:repo) }

  it "updates the repo" do
    VCR.use_cassette('features/repos/update', record: :new_episodes) do
      sign_in user

      visit repo_path(repo)
      click_on "Edit"
      expect(current_path).to eq(edit_repo_path(repo))

      # TODO: Specs for javascript fields, including category and parents assignment
      fill_in "description", with: "New_Description"
      click_on "Update"

      expect(current_path).to eq(repo_path(repo))
      expect(page).to have_content(/Repo has been updated/)

      expect(page).to have_content("New_Description")
    end
  end
end

describe Repo, "destroy repo" do
  include_context "repo features"

  it "destroys the repo" do
    sign_in staff

    visit edit_repo_path(repo)
    expect(current_path).to eq(edit_repo_path(repo))

    click_on "Destroy"

    expect(current_path).to eq(root_path)
    expect(page).to have_content(/Repo has been destroyed/)
  end
end
