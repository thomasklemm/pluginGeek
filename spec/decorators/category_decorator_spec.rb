require 'spec_helper'

describe CategoryDecorator do
  subject(:category) do
    category = Fabricate.build(:category)
    category.decorate
  end

  it "decorates associated repos" do
    expect(category.repos).to be_decorated
  end

  it "decorates associated similar_categories" do
    expect(category.similar_categories).to be_decorated
  end

  it "decorates associated extended_links" do
    expect(category.extended_links).to be_decorated
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
    it "returns the category's stars with a delimiter" do
      category.stars = 1000
      expect(category.stars).to match(/1,000/)
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

  describe "cached repo list accessors" do
    describe "#repo_names" do
      it "returns an array of all the repos' names" do
        category.repo_list = "rails/rails, sinatra/sinatra"
        expect(category.repo_names).to eq(%w(rails/rails sinatra/sinatra))
      end

      it "returns an empty array when cached repo_list is empty" do
        category.repo_list = ""
        expect(category.repo_names).to eq([])
      end
    end

    describe "#popular_repo_names" do
      it "returns a string with the two highest scoring repos' names" do
        category.repo_list = "rails/rails, sinatra/sinatra, espresso/espresso"
        expect(category.popular_repo_names).to eq("rails/rails, sinatra/sinatra")
      end

      it "returns an empty string when cached repo_list is empty" do
        category.repo_list = ""
        expect(category.popular_repo_names).to eq("")
      end
    end

    describe "#further_repo_names" do
      it "returns a string with the all except the two highest scoring repos' names" do
        category.repo_list = "rails/rails, sinatra/sinatra, espresso/espresso, twitter/bootstrap"
        expect(category.further_repo_names).to eq("espresso/espresso, twitter/bootstrap")
      end

      it "returns an empty string when cached repo_list is empty" do
        category.repo_list = ""
        expect(category.further_repo_names).to eq("")
      end
    end

    describe "#show_repos_link_text" do
      it "returns a count and an arrow if more than three repos" do
        category.repos_count = 10
        expect(category.show_repos_link_text).to eq(" and 8 more &raquo;")
      end

      it "returns an arraw if up to two repos" do
        category.repos_count = 2
        expect(category.show_repos_link_text).to eq(" &raquo;")
      end
    end
  end
end
