require 'spec_helper'

describe Platform do
  subject(:platform) { Fabricate.build(:platform) }
  it { should be_valid }

  describe 'validations' do
    before { platform.save }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:position) }
    it { should validate_presence_of(:slug) }
    it { should validate_uniqueness_of(:slug) }
  end

  describe 'associations' do
    it { should have_many(:categories).through(:platform_categories) }
    it { should have_many(:platform_categories).dependent(:destroy)}
  end

  describe "#to_param" do
    it 'returns the slug' do
      platform.slug = 'ruby'
      expect(platform.to_param).to eq('ruby')
    end
  end
end
