# == Schema Information
#
# Table name: categories
#
#  id                :integer          not null, primary key
#  name              :string(255)      not null
#  slug              :string(255)      not null
#  repo_count        :integer          default(0)
#  watcher_count     :integer          default(0)
#  knight_score      :integer          default(0)
#  short_description :text
#  description       :text
#  popular_repos     :string(255)
#  all_repos         :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  label             :string(255)
#

require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
