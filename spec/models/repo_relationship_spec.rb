require 'spec_helper'

describe RepoRelationship do
  subject(:repo_relationship) { Fabricate.build(:repo_relationship) }
  it { should be_valid }

  it { should belong_to(:parent).class_name('Repo') }
  it { should belong_to(:child).class_name('Repo') }

  it { should validate_presence_of(:parent) }
  it { should validate_presence_of(:child) }
end
