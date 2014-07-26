require 'spec_helper'

describe Platform do
  let(:ruby) { platform_for(:ruby) }
  let(:javascript) { platform_for(:javascript) }
  let(:global) { Platform::Global.instance }

  describe 'platform finders' do
    subject { described_class }

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

    describe '.html_css' do
      it 'returns the HTML/CSS platform' do
        expect(described_class.html_css).to eq platform_for(:html_css)
      end
    end

    describe '.ios' do
      it 'returns the HTML/CSS platform' do
        expect(described_class.ios).to eq platform_for(:ios)
      end
    end

    describe '.android' do
      it 'returns the HTML/CSS platform' do
        expect(described_class.android).to eq platform_for(:android)
      end
    end

    describe '.global' do
      it 'returns the global platform' do
        expect(described_class.global).to eq global
      end
    end
  end

  describe 'class methods' do
    subject { described_class }

    describe '.all' do
      it 'returns all platforms in the given order' do
        expect(described_class.all).to eq [
          platform_for(:ruby),
          platform_for(:javascript),
          platform_for(:html_css),
          platform_for(:ios),
          platform_for(:android)
        ]
      end
    end

    describe '.find' do
      it 'returns the platform, given a symbol' do
        expect(described_class.find(:ruby)).to eq ruby
      end

      it 'returns the platform, given a string' do
        expect(described_class.find('ruby')).to eq ruby
      end
    end

    describe '.find_all' do
      it 'returns the platforms, given multiple platform ids' do
        expect(
          described_class.find_all(:javascript, 'ruby')
        ).to eq [javascript, ruby]
      end

      it 'returns the platforms, given an array of platform ids' do
        expect(
          described_class.find_all([:javascript, 'ruby'])
        ).to eq [javascript, ruby]
      end

      it 'returns the platform, given a single platform id' do
        expect(
          described_class.find_all('ruby')
        ).to eq [ruby]
      end
    end

    describe '.current' do
      it 'returns the current platform, given a platform id' do
        expect(described_class.current(:ruby)).to eq ruby
      end
      it 'returns the global platform, when the global platform id' do
        expect(described_class.current(:global)).to eq global
      end
    end

  end

  describe 'instance methods' do
    subject(:platform) { platform_for(:ruby) }

    describe '#id' do
      it 'returns the parameterized id as a string' do
        platform.id = 'ruby'
        expect(platform.id).to eq 'ruby'

        platform.id = 'my-platform id'
        expect(platform.id).to eq 'my-platform_id'
      end
    end

    describe '#to_param' do
      it 'returns a URL-friendly id' do
        platform.id = 'my-platform id'
        expect(platform.to_param).to eq 'my-platform_id'
      end
    end

    describe '#to_s' do
      it 'returns the id' do
        platform.id = 'my_platform'
        expect(platform.to_s).to eq 'my_platform'
      end
    end

    describe 'object equality / ==' do
      it 'returns true for matching ids' do
        ruby = described_class.new(id: :ruby)
        another_ruby = described_class.new(id: :ruby)
        yet_another_ruby = described_class.new(id: 'ruby')

        expect(ruby).to eq another_ruby
        expect(ruby).to eq yet_another_ruby
      end

      it 'returns false for different ids' do
        ruby = described_class.new(id: :ruby)
        javascript = described_class.new(id: :javascript)

        expect(ruby).to_not eq javascript
      end
    end

    describe '#categories' do
      it 'returns the associated categories' do
        match_a = create(:category, platforms: [ruby])
        match_b = create(:category, platforms: [ruby, javascript])
        no_match = create(:category, platforms: [javascript])

        expect(ruby.categories).to match_array [match_a, match_b]
      end

      it 'returns an empty array when no categories are associated' do
        expect(ruby.categories).to eq []
      end
    end
  end
end
