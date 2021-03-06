require 'spec_helper'

describe Link do
  subject(:link) { Fabricate.build(:link) }
  it { should be_valid }

  it { should validate_presence_of(:url) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:published_at) }

  it { should belong_to(:submitter).class_name('User') }
  it { should validate_presence_of(:submitter) }

  it { should have_many(:link_relationships).dependent(:destroy) }
  it { should have_many(:repos).through(:link_relationships) }
  it { should have_many(:categories).through(:link_relationships) }

  describe "#extended_categories" do
    let(:category) { Fabricate.build(:category) }
    let(:repo_category) { Fabricate.build(:category) }
    let(:repo) { Fabricate.build(:repo) }

    before do
      repo.categories |= [repo_category]
      link.categories << category
      link.repos << repo
    end

    it "returns categories and categories of repos" do
      expect(link.extended_categories).to match_array([category, repo_category])
    end
  end

  describe "#expire_repos" do
    it "expires associated repos" do
      Timecop.freeze
      link.repos.expects(:update_all).with(updated_at: Time.current)
      link.send(:expire_repos)
      Timecop.return
    end
  end

  describe "#expire_categories" do
    it "expires associated categories" do
      Timecop.freeze
      link.categories.expects(:update_all).with(updated_at: Time.current)
      link.send(:expire_categories)
      Timecop.return
    end
  end

  describe "#expire_categories_of_repos" do
    let(:repo_category) { Fabricate(:category) }
    let(:repo) { Fabricate(:repo) }

    before do
      repo.categories |= [repo_category]
      link.repos << repo
      link.save
    end

    it "expires associated categories of repos" do
      Timecop.freeze
      link.send(:expire_categories_of_repos)
      expect(repo_category.reload.updated_at).to eq(Time.current)
      Timecop.return
    end
  end
end
