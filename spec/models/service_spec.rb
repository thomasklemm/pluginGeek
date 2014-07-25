require 'spec_helper'

describe Service do
  subject(:service) { build(:service) }

  describe 'validations' do
    before { service.save }
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
    let!(:category) { create(:category) }
    let!(:service) { create(:service, categories: [category]) }

    it "returns the category's services" do
      # Other service
      create(:service)

      services = Service.for_category(category)
      expect(services).to eq([service])
    end
  end
end
