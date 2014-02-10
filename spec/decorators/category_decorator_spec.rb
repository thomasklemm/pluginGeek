require 'spec_helper'

describe CategoryDecorator do
  subject(:category) do
    category = Fabricate.build(:category)
    category.decorate
  end

  describe "#description" do
    it "returns the category's description if present" do
      category.description = 'category description'
      expect(category.description).to eq('category description')
    end

    it "falls back to first repo's description if present" do
      repo = Fabricate.build(:repo, description: 'repo description')
      category.repos = [repo]
      expect(category.description).to eq('repo description')
    end

    it "else returns an empty string" do
      expect(category.description).to eq('')
    end
  end

  describe "#stars" do
    it "returns the category's stars with a delimiter" do
      category.stars = 1000
      expect(category.stars).to eq('1,000')
    end

    it "returns 0 if missing" do
      expect(category.stars).to eq('0')
    end
  end

  describe "#score" do
    it "returns the category's score if present" do
      category.score = 1000
      expect(category.score).to eq(1000)
    end

    it "returns 0 if missing" do
      expect(category.score).to eq(0)
    end
  end

  describe "#repo_links" do
    before { category.save }

    it "returns links to the first three repos" do
      r1, r2, r3, r4 = 4.times.map { Fabricate(:repo) }
      category.repos = [r1, r2, r3, r4]

      [r1, r2, r3].each do |repo|
        expect(category.repo_links).to include(helper.repo_path(repo))
      end

      expect(category.repo_links).not_to include(helper.repo_path(r4))
    end
  end
end
