require 'spec_helper'

describe Platform do
  def platform_for(platform_id)
    Platform.new(platform_attributes_for(platform_id))
  end

  def platform_attributes_for(platform_id)
    PLATFORMS.detect { |platform| platform[:id].to_s == platform_id.to_s }
  end

  describe 'class methods' do
    describe '.ruby' do
      it 'returns the Ruby platform' do
        expect(described_class.ruby).to eq platform_for(:ruby)
      end
    end

    describe '.javascript' do
      it 'returns the JavaScript platform' do
        expect(described_class.javascript).to eq platform_for(:javascript)
      end
    end

    describe '.find' do
      it 'returns the platform, given a symbol' do
        expect(described_class.find(:ruby)).to eq platform_for(:ruby)
      end

      it 'returns the platform, given a string' do
        expect(described_class.find('ruby')).to eq platform_for(:ruby)
      end
    end

    describe '.all' do
      it 'returns all platforms' do
        expect(described_class.all).to match_array([
          platform_for(:ruby),
          platform_for(:javascript)
        ])
      end
    end
  end

  describe 'instance methods' do
    subject(:platform) { described_class.new }

    describe '#id' do
      it 'returns the id as a symbol' do
        platform.id = 'ruby'
        expect(platform.id).to eq(:ruby)
      end
    end

    describe 'object equality / ==' do
      it 'returns true for matching ids' do
        ruby = described_class.new(id: :ruby)
        another_ruby = described_class.new(id: :ruby)
        yet_another_ruby = described_class.new(id: 'ruby')

        expect(ruby).to eq(another_ruby)
        expect(ruby).to eq(yet_another_ruby)
      end

      it 'returns false for different ids' do
        ruby = described_class.new(id: :ruby)
        javascript = described_class.new(id: :javascript)

        expect(ruby).to_not eq(javascript)
      end
    end
  end
end


# describe Platform do
#   subject(:platform) { Fabricate.build(:platform) }
#   it { should be_valid }
#
#   describe 'validations' do
#     before { platform.save }
#     it { should validate_presence_of(:name) }
#     it { should validate_presence_of(:position) }
#     it { should validate_presence_of(:slug) }
#     it { should validate_uniqueness_of(:slug) }
#   end
#
#   describe 'associations' do
#     it { should have_many(:categories).through(:platform_categories) }
#     it { should have_many(:platform_categories).dependent(:destroy)}
#   end
#
#   describe "#to_param" do
#     it 'returns the slug' do
#       platform.slug = 'ruby'
#       expect(platform.to_param).to eq('ruby')
#     end
#   end
# end
