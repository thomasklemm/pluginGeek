require 'spec_helper'

describe LinkRelationship do
  subject { Fabricate.build(:link_relationship) }
  it { should be_valid }

  it { should belong_to(:link) }
  it { should belong_to(:linkable) }
end
