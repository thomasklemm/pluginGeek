# == Schema Information
#
# Table name: category_relationships
#
#  category_id       :integer
#  created_at        :datetime         not null
#  id                :integer          not null, primary key
#  other_category_id :integer
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_category_relationships_on_category_id        (category_id)
#  index_category_relationships_on_other_category_id  (other_category_id)
#

require 'spec_helper'

describe CategoryRelationship do
  subject { Fabricate(:category_relationship) }
  it { should be_valid }

  it { should belong_to(:category) }
  it { should belong_to(:other_category).class_name('Category') }

  it { should validate_presence_of(:category) }
  it { should validate_presence_of(:other_category) }
end
