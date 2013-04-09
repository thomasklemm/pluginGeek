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

  describe ".random(count)" do
    before do
      4.times { Fabricate(:service) }
    end

    it "returns a set of records of given count" do
      services = Service.random(2).to_a
      expect(services).to be_an Array
      expect(services).to have(2).items
      expect(services.first).to be_a Service
    end

    it "returns a random set of records" do
      expect(Service.random(2).to_a).to_not eq(Service.random(2).to_a)
    end
  end

  describe ".for_category(category)" do
    let(:category) { Fabricate(:category) }

    before do
      4.times { service = Fabricate(:service, categories: [category]) }
      Fabricate(:service)
    end

    it "returns the category's services" do
      services = Service.for_category(category)
      expect(services).to be_an Array
      expect(services).to have(4).items
      expect(services.first).to be_a Service
    end

    it "shuffles the results" do
      expect(Service.for_category(category).to_a).to_not eq(Service.for_category(category).to_a)
    end
  end
end
