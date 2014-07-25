require 'spec_helper'

describe Category::Platform do
  let(:ruby) { platform_for(:ruby) }

  describe '#platform' do
    it 'returns the platform' do
      subject.platform_id = 'ruby'
      expect(subject.platform).to eq ruby
    end
  end

  describe '#platform=' do
    it 'sets the platform id' do
      subject.platform = ruby
      expect(subject.platform_id).to eq ruby.id
      expect(subject.platform).to eq ruby
    end
  end
end
