# == Schema Information
#
# Table name: languages
#
#  created_at :datetime         not null
#  id         :integer          not null, primary key
#  name       :text
#  parent_id  :integer
#  slug       :text
#  updated_at :datetime         not null
#
# Indexes
#
#  index_languages_on_slug  (slug) UNIQUE
#

Fabricator(:language) do
  name { %w(ruby javascript webdesign).sample }
end
