require 'spec_helper'

describe Repo do
  subject(:repo) { Fabricate.build(:repo) }
  it { should be_valid }

  describe 'validations' do
    before { repo.save }
    it { should validate_presence_of(:owner_and_name) }
    it { should validate_uniqueness_of(:owner_and_name) }
  end

  it { should have_many(:categories).through(:categorizations) }
  it { should have_many(:categorizations).dependent(:destroy) }

  it { should have_many(:parents).through(:parent_child_relationships) }
  it { should have_many(:parent_child_relationships).class_name('RepoRelationship').dependent(:destroy) }

  it { should have_many(:children).through(:child_parent_relationships) }
  it { should have_many(:child_parent_relationships).class_name('RepoRelationship').dependent(:destroy) }

  it { should have_many(:links).through(:link_relationships) }
  it { should have_many(:link_relationships).dependent(:destroy) }

  describe ".find_by_owner_and_name" do
    it "finds repos by case-insensitive owner_and_name" do
      rails = Fabricate(:repo, owner_and_name: 'rails/rails')
      expect(Repo.find_by_owner_and_name('rails/rails')).to eq(rails)
    end

    it "returns nil if no record is found" do
      expect(Repo.find_by_owner_and_name('rails/rails')).to be_nil
    end
  end

  describe ".find_by_owner_and_name!" do
    it "raises an error if no record is found" do
      expect{ Repo.find_by_owner_and_name!('rails/rails') }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe "#stars" do
    it "returns the stars count" do
      repo.stars = 1
      expect(repo.stars).to eq(1)
    end

    it "returns 0 when missing" do
      repo.stars = nil
      expect(repo.stars).to eq(0)
    end
  end

  describe "#score" do
    it "returns the score" do
      repo.score = 1
      expect(repo.score).to eq(1)
    end

    it "returns 0 when missing" do
      repo.score = nil
      expect(repo.score).to eq(0)
    end
  end

  describe "#to_param" do
    it "returns the owner_and_name" do
      repo.owner_and_name = 'thomasklemm/rails'
      expect(repo.to_param).to eq('thomasklemm/rails')
    end
  end
end
