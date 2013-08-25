require 'spec_helper'

describe Authentication do
  subject { Fabricate.build(:authentication) }
  it { should be_valid }

  it { should belong_to(:user) }
  it { should validate_presence_of(:user) }

  it { should validate_presence_of(:provider) }
  it { should validate_presence_of(:uid) }
end
