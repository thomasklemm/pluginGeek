require 'spec_helper'

feature 'Platform navigation' do
  Platform.all.each do |platform|
    it "recognizes the '#{platform.name}' platform" do
      ensure_on global_platform_path
      click_link platform.name
      expect(current_path).to eq platform_path(platform.id)
    end
  end
end

feature 'Platform' do
  given!(:ruby_category) do
    create(:category, {
      name: 'Ruby category',
      platform_ids: ['ruby']
    })
  end

  given!(:javascript_category) do
    create(:category, {
      name: 'Javascript category',
      platform_ids: ['javascript']
    })
  end

  it 'lists the associated categories' do
    ensure_on platform_path(:ruby)

    expect(page).to have_content(ruby_category.name)
    expect(page).to have_no_content(javascript_category.name)
  end
end

feature 'Global platform' do
  given!(:ruby_category) do
    create(:category, {
      name: 'Ruby category',
      platform_ids: ['ruby']
    })
  end

  given!(:javascript_category) do
    create(:category, {
      name: 'Javascript category',
      platform_ids: ['javascript']
    })
  end

  it 'lists all categories' do
    ensure_on global_platform_path

    expect(page).to have_content(ruby_category.name)
    expect(page).to have_content(javascript_category.name)
  end
end
