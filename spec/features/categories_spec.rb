require 'spec_helper'

feature "Categories" do
  let(:language) { Fabricate(:language, name: 'Ruby') }
  let(:category) { Fabricate(:category) }
  let(:repo) { Fabricate(:repo) }
  let(:similar_category) { Fabricate(:category) }
  let(:link) { Fabricate(:link) }
  let(:link_via_repo) { Fabricate(:link) }

  scenario "#index" do
    category.languages << language
    category.repos << repo
    category.save

    path = categories_path('ruby')
    visit path
    expect(current_path).to eq(path)

    expect(page).to have_content(category.full_name)
    expect(page).to have_content(repo.full_name)
  end

  scenario "#show" do
    category.languages << language
    category.repos << repo
    category.related_categories << similar_category
    category.links << link
    repo.links << link_via_repo

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

  scenario "#edit", "signed in" do
    # path = edit_category_path(category)
    # visit path
    # expect(current_path).to eq(path)
  end

  scenario "#update", "signed in" do

  end

  scenario "#destroy", "signed in as staff" do

  end
end
