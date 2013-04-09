# == Schema Information
#
# Table name: services
#
#  created_at  :datetime         not null
#  description :text
#  display_url :text
#  id          :integer          not null, primary key
#  name        :text
#  target_url  :text
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe Service do
  subject { Fabricate.build(:service) }
  it { should be_valid }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:display_url) }
  it { should validate_presence_of(:target_url) }
  it { should validate_presence_of(:description) }

  it { should have_many(:service_categorizations).dependent(:destroy) }
  it { should have_many(:categories).through(:service_categorizations) }
end
