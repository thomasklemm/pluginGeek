require 'spec_helper'

describe CategoryRelationship do
  subject { Fabricate(:category_relationship) }
  it { should be_valid }

  it { should belong_to(:category) }
  it { should belong_to(:other_category).class_name('Category') }

  it { should validate_presence_of(:category) }
  it { should validate_presence_of(:other_category) }
end
