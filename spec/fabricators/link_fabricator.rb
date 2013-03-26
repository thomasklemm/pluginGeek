# == Schema Information
#
# Table name: links
#
#  author       :text
#  author_url   :text
#  created_at   :datetime         not null
#  id           :integer          not null, primary key
#  maker_id     :integer
#  published_at :date             not null
#  title        :text             not null
#  updated_at   :datetime         not null
#  url          :text             not null
#

Fabricator(:link) do
  url            { sequence(:url) { |n| "url_#{ n }" } }
  title          "link title"
  published_at   Date.current

  maker          { Fabricate(:user) }
end
