require 'spec_helper'

describe Platform::Global do
  subject(:global) { described_class.instance }

  describe '.global_id?' do
    it 'returns true if the global id is given as a string'
    it 'returns true if the global id is given as a symbol'
    it 'returns false if another identifier is given'
  end

  describe '#id' do
    it 'returns the global id'
  end

  describe '#categories' do
    it 'returns a relation for all categories'
  end

  describe '#categories_count' do
    it 'returns a count including all categories'
  end
end
