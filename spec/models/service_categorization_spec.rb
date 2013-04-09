# == Schema Information
#
# Table name: service_categorizations
#
#  category_id :integer
#  created_at  :datetime         not null
#  id          :integer          not null, primary key
#  service_id  :integer
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_service_categorizations_on_category_id  (category_id)
#  index_service_categorizations_on_service_id   (service_id)
#

require 'spec_helper'

describe ServiceCategorization do
  subject { Fabricate.build(:service_categorization) }
  it { should be_valid }

  it { should belong_to(:service) }
  it { should validate_presence_of(:service) }

  it { should belong_to(:category) }
  it { should validate_presence_of(:category) }
end
