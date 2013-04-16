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

shared_context "repo" do
  let!(:language) { Fabricate(:language, name: "Ruby") }
  let!(:category) { Fabricate(:category, languages: [language], repos: [repo]) }
  let!(:repo)     { Fabricate(:repo, full_name: 'rails/rails', stars: 42) }

  let(:user)  { Fabricate(:user) }
  let(:staff) { Fabricate(:user, staff: true) }
end

describe Repo, "show repo" do
  include_context "repo"
  let!(:parent)   { Fabricate(:repo, children: [repo]) }
  let!(:child)    { Fabricate(:repo, parents: [repo]) }
  let!(:link)     { Fabricate(:link, repos: [repo]) }

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
  include_context "repo"
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

describe Repo, "refresh repo" do
  include_context "repo"

  it "refreshes the repo" do
    VCR.use_cassette('features/repos/refresh', record: :new_episodes) do
      sign_in staff

      visit repo_path(repo)
      click_on "Refresh"

      expect(current_path).to eq(repo_path(repo))
      expect(page).to have_content(/Repo has been refreshed/)
    end
  end
end

describe Repo, "destroy repo" do
  include_context "repo"

  it "destroys the repo" do
    sign_in staff

    visit edit_repo_path(repo)
    expect(current_path).to eq(edit_repo_path(repo))

    click_on "Destroy"

    expect(current_path).to eq(root_path)
    expect(page).to have_content(/Repo has been destroyed/)
  end
end
