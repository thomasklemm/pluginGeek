# == Schema Information
#
# Table name: categories
#
#  all_repos     :text
#  created_at    :datetime         not null
#  description   :text
#  id            :integer          not null, primary key
#  knight_score  :integer
#  label         :string(255)
#  name          :string(255)
#  popular_repos :string(255)
#  repo_count    :integer
#  slug          :string(255)
#  updated_at    :datetime         not null
#  watcher_count :integer
#
# Indexes
#
#  index_categories_on_slug  (slug) UNIQUE
#

require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
