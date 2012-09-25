# == Schema Information
#
# Table name: repo_relationships
#
#  id         :integer          not null, primary key
#  parent_id  :integer
#  child_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class RepoRelationshipTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
