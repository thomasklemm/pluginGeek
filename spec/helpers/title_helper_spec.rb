require 'spec_helper'

describe TitleHelper do
  describe "#page_title" do
    it "returns custom title when given" do
      helper.content_for(:page_title) { "Custom title" }
      expect(helper.page_title).to eq("Custom title")
    end

    it "returns categories_title when on categories#index" do
      assign(:categories, true)
      assign(:language, Fabricate.build(:language, name: "Ruby"))
      expect(helper.page_title).to match(/Ruby/)
    end

    it "returns category_title when on categories#show" do
      assign(:category, Fabricate.build(:category, full_name: "Category"))
      expect(helper.page_title).to match(/Category/)
    end

    it "returns repo_title when on repos#show" do
      assign(:repo, Fabricate.build(:repo, full_name: "rails/rails"))
      expect(helper.page_title).to match(/rails\/rails/)
    end

    it "returns default title " do
      expect(helper.page_title).to eq(helper.send(:default_title))
    end
  end
end
