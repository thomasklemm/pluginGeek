require 'spec_helper'

describe Category do
  subject(:category) { Fabricate.build(:category) }
  it { should be_valid }

  it { should validate_presence_of(:name) }
  it { should ensure_length_of(:description).is_at_most(360) }

  it { should have_many(:platforms).through(:platform_categories) }
  it { should have_many(:platform_categories).dependent(:destroy) }

  it { should have_many(:repos).through(:categorizations) }
  it { should have_many(:categorizations).dependent(:destroy) }

  it { should have_many(:links).through(:link_relationships) }
  it { should have_many(:link_relationships).dependent(:destroy) }

  describe "#extended_links" do
    let(:repo) { Fabricate(:repo) }
    let(:link) { Fabricate(:link) }
    let(:link_via_repo) { Fabricate(:link) }

    before do
      category.save
      category.repos << repo
      category.links << link
      repo.links     << link_via_repo
      category.save
    end

    it "returns links of the category and it's associated repos" do
      expect(category.extended_links).to match_array([link, link_via_repo])
    end
  end

  it { should have_many(:related_categories).through(:category_relationships) }
  it { should have_many(:category_relationships).dependent(:destroy) }

  it { should have_many(:reverse_related_categories).through(:reverse_category_relationships) }
  it { should have_many(:reverse_category_relationships).dependent(:destroy) }

  describe "#similar_categories" do
    let(:related_category) { Fabricate(:category) }
    let(:reverse_related_category) { Fabricate(:category) }

    before do
      category.related_categories << related_category
      category.reverse_related_categories << reverse_related_category
    end

    it "returns all similar categories, regardless of direction of association" do
      expect(category.similar_categories).to match_array([related_category, reverse_related_category])
    end
  end

  it { should have_many(:services).through(:service_categorizations) }
  it { should have_many(:service_categorizations).dependent(:destroy) }
end
