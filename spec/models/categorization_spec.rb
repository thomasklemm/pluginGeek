require 'spec_helper'

describe Categorization do
  subject { Fabricate.build(:categorization) }
  it { should be_valid }

  it { should belong_to(:repo) }
  it { should belong_to(:category) }
end
