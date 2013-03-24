# == Schema Information
#
# Table name: repo_relationships
#
#  child_id   :integer          not null
#  created_at :datetime         not null
#  id         :integer          not null, primary key
#  parent_id  :integer          not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_repo_relationships_on_child_id                (child_id)
#  index_repo_relationships_on_parent_id               (parent_id)
#  index_repo_relationships_on_parent_id_and_child_id  (parent_id,child_id) UNIQUE
#

require 'spec_helper'

describe RepoRelationship do
  subject { Fabricate.build(:repo_relationship) }
  it { should be_valid }

  it { should belong_to(:parent).class_name('Repo') }
  it { should belong_to(:child).class_name('Repo') }

  it { should validate_presence_of(:parent) }
  it { should validate_presence_of(:child) }
end
