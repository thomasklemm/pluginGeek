require 'spec_helper'

describe Categorization do
  subject { Fabricate.build(:categorization) }
  it { should be_valid }

  it { should belong_to(:repo) }
  it { should belong_to(:category) }

  it { should validate_presence_of(:repo) }
  it { should validate_presence_of(:category) }
end
