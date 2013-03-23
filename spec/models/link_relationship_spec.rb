require 'spec_helper'

describe LinkRelationship do
  subject(:link_relationship) { Fabricate.build(:link_relationship) }
  it { should be_valid }

  it { should belong_to(:link) }
  it { should belong_to(:linkable) }

  it { should validate_presence_of(:link) }
  it { should validate_presence_of(:linkable) }
end
