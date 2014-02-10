require 'spec_helper'

describe PlatformCategory do
  subject { Fabricate.build(:platform_category) }
  it { should be_valid }

  it { should belong_to(:platform) }
  it { should belong_to(:category) }
end
