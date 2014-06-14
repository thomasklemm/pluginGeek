require 'spec_helper'

describe Service do
  subject(:service) { Fabricate.build(:service) }
  it { should be_valid }

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:display_url) }
    it { should validate_presence_of(:target_url) }
    it { should validate_presence_of(:description) }
  end

  describe 'associations' do
    it { should have_many(:categories).through(:service_categorizations) }
    it { should have_many(:service_categorizations).dependent(:destroy) }
  end

  describe ".for_category" do
    let!(:category) { Fabricate(:category) }
    let!(:service) { Fabricate(:service, categories: [category]) }

    it "returns the category's services" do
      # Other service
      Fabricate(:service)

      services = Service.for_category(category)
      expect(services).to eq([service])
    end
  end
end
