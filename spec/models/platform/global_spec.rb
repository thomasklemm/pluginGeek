require 'spec_helper'

describe Platform::Global do
  subject(:global) { described_class.instance }

  describe '.global_id?' do
    it 'returns true if the global id is given as a string' do
      expect(described_class.global_id?('global')).to be_truthy
    end

    it 'returns true if the global id is given as a symbol' do
      expect(described_class.global_id?(:global)).to be_truthy
    end

    it 'returns false if another identifier is given' do
      expect(described_class.global_id?('ruby')).to be_falsey
    end
  end

  describe '#id' do
    it 'returns the global id' do
      expect(global.id).to eq 'global'
    end
  end

  describe '#categories' do
    it 'returns a relation for all categories' do
      expect(Category).to receive(:all).and_return('all categories')
      expect(global.categories).to eq 'all categories'
    end
  end

  describe '#categories_count' do
    it 'returns a count including all categories' do
      expect(Category).to receive(:count).and_return(42)
      expect(global.categories_count).to eq 42
    end
  end
end
