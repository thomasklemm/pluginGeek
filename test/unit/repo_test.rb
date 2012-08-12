# == Schema Information
#
# Table name: repos
#
#  id                   :integer          not null, primary key
#  full_name            :string(255)      not null
#  owner                :string(255)
#  name                 :string(255)
#  watchers             :integer          default(0)
#  forks                :integer          default(0)
#  description          :text
#  github_url           :string(255)
#  homepage_url         :string(255)
#  knight_score         :integer          default(0)
#  github_updated_at    :datetime
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  label                :string(255)
#  cached_category_list :string(255)
#  cached_child_list    :string(255)
#  cached_language_list :string(255)
#  update_success       :boolean          default(FALSE)
#

require 'test_helper'

class RepoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
