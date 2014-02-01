require 'spec_helper'

describe RepoDecorator do
  subject(:repo) do
    repo = Fabricate.build(:repo)
    repo.decorate
  end

  it "decorates associated categories" do
    expect(repo.categories).to be_decorated
  end

  it "decorates associated parents_and_children" do
    expect(repo.parents_and_children).to be_decorated
  end

  describe "#owner" do
    it "returns the owner when given" do
      repo.owner = "owner"
      expect(repo.owner).to eq("owner")
    end

    it "splits the full_name and returns the owner part when owner not given" do
      repo.owner = ""
      repo.full_name = "owner/name"
      expect(repo.owner).to eq("owner")
    end
  end

  describe "#name" do
    it "returns the name when given" do
      repo.name = "name"
      expect(repo.name).to eq("name")
    end

    it "splits the full_name and returns the name part when name not given" do
      repo.name = ""
      repo.full_name = "owner/name"
      expect(repo.name).to eq("name")
    end
  end

  describe "#stars" do
    before { repo.stars = 1000 }

    it "returns the stars with as number with delimiter" do
      expect(repo.stars).to match(/1,000/)
    end
  end

  describe "#description" do
    it "returns the description when given" do
      repo.description = "description"
      expect(repo.description).to eq("description")
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
      repo.full_name = "rails/rails"
      repo.homepage_url = ""
      expect(repo.github_url).to eq("https://github.com/rails/rails")
    end
  end

  describe "#github_url" do
    it "returns the url of the repo on github" do
      repo.full_name = "rails/rails"
      expect(repo.github_url).to eq("https://github.com/rails/rails")
    end
  end

  describe "#timestamp" do
    it "returns the github_updated_at as an iso8601 timestamp" do
      Timecop.freeze
      repo.github_updated_at = 1.day.ago
      expect(repo.timestamp).to eq(1.day.ago.iso8601)
      Timecop.return
    end
  end

  describe "#written_timestamp" do
    it "returns the github_updated_at in words" do
      Timecop.freeze
      repo.github_updated_at = 1.day.ago
      expect(repo.written_timestamp).to eq(1.day.ago.to_s(:long))
      Timecop.return
    end
  end

  describe "#activity_class" do
    it "returns a CSS class name based on the last update on Github" do
      repo.github_updated_at = 1.second.ago
      expect(repo.activity_class).to eq('high')

      repo.github_updated_at = 3.months.ago
      expect(repo.activity_class).to eq('high')

      repo.github_updated_at = 4.months.ago
      expect(repo.activity_class).to eq('medium')

      repo.github_updated_at = 11.months.ago
      expect(repo.activity_class).to eq('medium')

      repo.github_updated_at = 12.months.ago
      expect(repo.activity_class).to eq('low')

      repo.github_updated_at = 24.months.ago
      expect(repo.activity_class).to eq('low')

      repo.github_updated_at = nil
      expect(repo.activity_class).to eq('low')
    end
  end
end
