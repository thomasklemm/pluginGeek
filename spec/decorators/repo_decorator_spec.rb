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

  describe "#description"
  describe "#github_description"
  describe "#homepage_url"
  describe "#timestamp"
  describe "#written_timestamp"
  describe "#activity_class"
end
