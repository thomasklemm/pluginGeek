require 'spec_helper'

describe CategoryDecorator do
  subject(:category) { Fabricate.build(:category).decorate }

  it "decorates associated repos" do
    category.repos << Fabricate.build(:repo)
    expect(category.repos).to be_decorated
  end

  it "decorated associated similar_categories" do
    category.related_categories << Fabricate.build(:category)
    expect(category.similar_categories).to be_decorated
  end

  describe "#description" do
    it "returns the category's description when given" do
      category.description = "description"
      expect(category.description).to eq("description")
    end

    it "returns an empty string if missing" do
      expect(category.description).to eq("")
    end
  end

  describe "#stars" do
    it "returns the category's stars when given" do
      category.stars = 100
      expect(category.stars).to eq(100)
    end

    it "returns zero if missing" do
      expect(category.stars).to eq(0)
    end
  end

  describe "#score" do
    it "returns the category's score when given" do
      category.score = 100
      expect(category.score).to eq(100)
    end

    it "returns zero if missing" do
      expect(category.score).to eq(0)
    end
  end
end
