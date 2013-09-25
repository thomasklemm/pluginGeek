require 'spec_helper'

describe ServiceCategorization do
  subject { Fabricate.build(:service_categorization) }
  it { should be_valid }

  it { should belong_to(:service) }
  it { should belong_to(:category) }
end
