require 'spec_helper'

describe Array do
  describe "#cache_key" do

    context "empty array" do
      it "returns 'empty' as a cache_key" do
        key = ActiveSupport::Cache.expand_cache_key([])
        expect(key).to eq('empty')
      end
    end

    context "array with various objects" do
      it "generates a cache_key based on the objects' string representation" do
        key = ActiveSupport::Cache.expand_cache_key([1, 1.2, '2', 'string'])
        expect(key).to eq('1/1.2/2/string')
      end
    end

    context "array with lots of various objects" do
      let(:category) { Fabricate(:category) }

      it "generates a collection cache_key by digesting the items' cache keys or string representations" do
        array = [category, '0' * 100]

        key = ActiveSupport::Cache.expand_cache_key(array)
        digest = Digest::MD5.hexdigest([category.cache_key, '0' * 100].to_param)

        expect(key).to eq(digest)
      end
    end

    context "array of ActiveRecord objects" do
      let(:categories) { (1..2).map { Fabricate(:category) } }

      it "generates a collection cache_key based on the items' cache keys" do
        key = ActiveSupport::Cache.expand_cache_key(categories)
        expect(key).to eq(categories.map(&:cache_key).to_param)
      end
    end

    context "array with lots of ActiveRecord objects" do
      let(:categories) { (1..4).map { Fabricate(:category) } }

      it "generates a collection cache_key by digesting the items' cache keys" do
        key = ActiveSupport::Cache.expand_cache_key(categories)
        digest = Digest::MD5.hexdigest(categories.map(&:cache_key).to_param)

        expect(key).to eq(digest)
      end
    end

  end
end
