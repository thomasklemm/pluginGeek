require 'spec_helper'

describe ServiceCategorization do
  subject { Fabricate.build(:service_categorization) }
  it { should be_valid }

  it { should belong_to(:service) }
  it { should validate_presence_of(:service) }

  it { should belong_to(:category) }
  it { should validate_presence_of(:category) }
end
