# == Schema Information
#
# Table name: repos
#
#  created_at        :datetime         not null
#  description       :string(255)
#  forks             :integer
#  full_name         :string(255)
#  github_updated_at :datetime
#  github_url        :string(255)
#  homepage_url      :string(255)
#  id                :integer          not null, primary key
#  knight_score      :integer
#  name              :string(255)
#  owner             :string(255)
#  updated_at        :datetime         not null
#  watchers          :integer
#

require 'test_helper'

class RepoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
