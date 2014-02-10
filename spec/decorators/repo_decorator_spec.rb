require 'spec_helper'

describe RepoDecorator do
  subject(:repo) do
    repo = Fabricate.build(:repo)
    repo.decorate
  end

  describe "#owner" do
    it "returns the owner" do
      repo.owner_and_name = "owner/name"
      expect(repo.owner).to eq("owner")
    end
  end

  describe "#name" do
    it "returns the name" do
      repo.owner_and_name = "owner/name"
      expect(repo.name).to eq("name")
    end
  end

  describe "#stars" do
    before { repo.stars = 1000 }

    it "returns the stars with as number with delimiter" do
      expect(repo.stars).to eq('1,000')
    end
  end

  describe "#description" do
    it "returns the description when given" do
      repo.description = "repo description"
      expect(repo.description).to eq("repo description")
    end

    it "returns a default description when repo has no description on Github" do
      expect(repo.description).to match(/add a description/i)
    end
  end

  describe "#homepage_url" do
    it "returns the homepage_url when given" do
      repo.homepage_url = "http://rubyonrails.org/"
      expect(repo.homepage_url).to eq("http://rubyonrails.org/")
    end

    it "returns urls prefixed with http://" do
      repo.homepage_url = "activeadmin.info"
      expect(repo.homepage_url).to eq("http://activeadmin.info")
    end

    it "returns the github_url if no homepage is missing" do
      repo.owner_and_name = "rails/rails"
      repo.homepage_url = ""
      expect(repo.github_url).to eq("https://github.com/rails/rails")
    end
  end

  describe "#github_url" do
    it "returns the url of the repo on github" do
      repo.owner_and_name = "rails/rails"
      expect(repo.github_url).to eq("https://github.com/rails/rails")
    end
  end
end
