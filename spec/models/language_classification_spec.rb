require 'spec_helper'

describe LanguageClassification do
  subject { Fabricate.build(:language_classification) }
  it { should be_valid }

  it { should belong_to(:language) }
  it { should belong_to(:classifier) }

  it { should validate_presence_of(:language) }
  it { should validate_presence_of(:classifier) }
end
