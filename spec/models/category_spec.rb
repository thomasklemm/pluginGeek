require 'spec_helper'

describe Category do
  subject(:category) { build(:category) }

  describe 'validations' do
    before { category.save }
    it { should validate_presence_of(:name) }
    it { should ensure_length_of(:description).is_at_most(240) }
  end

  describe 'associations' do
    it { should have_many(:repos).through(:categorizations) }
    it { should have_many(:categorizations).dependent(:destroy) }

    it { should have_many(:related_categories).through(:category_relationships) }
    it { should have_many(:category_relationships).dependent(:destroy) }

    it { should have_many(:reverse_related_categories).through(:reverse_category_relationships) }
    it { should have_many(:reverse_category_relationships).dependent(:destroy) }

    it { should have_many(:links).through(:link_relationships) }
    it { should have_many(:link_relationships).dependent(:destroy) }

    it { should have_many(:services).through(:service_categorizations) }
    it { should have_many(:service_categorizations).dependent(:destroy) }
  end

  describe 'platform associations' do
    let(:ruby) { platform_for(:ruby) }
    let(:javascript) { platform_for(:javascript) }

    describe '#platforms' do
      it 'returns the associated platforms' do
        category.platform_ids = ['ruby', 'javascript']
        expect(category.platforms).to eq [ruby, javascript]
      end
    end

    describe '#platforms=' do
      it 'sets the given platforms' do
        category.platforms = [ruby]
        expect(category.platforms).to eq [ruby]

        category.platforms = [ruby, javascript]
        expect(category.platforms).to eq [ruby, javascript]
      end
    end

    describe '#platform_ids=' do
      it 'set the given platform_ids and platforms' do
        category.platform_ids = ['ruby']
        expect(category.platforms).to eq [ruby]

        category.platform_ids = ['ruby', 'javascript']
        expect(category.platforms).to eq [ruby, javascript]
      end
    end
  end
end
