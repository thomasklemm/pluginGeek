require 'spec_helper'

describe RepoRelationship do
  subject { Fabricate.build(:repo_relationship) }
  it { should be_valid }

  it { should belong_to(:parent).class_name('Repo') }
  it { should belong_to(:child).class_name('Repo') }
end
