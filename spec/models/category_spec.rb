require 'spec_helper'

describe Category do
  subject(:category) { Fabricate.build(:category) }
  it { should be_valid }

  it { should validate_presence_of(:full_name) }
  it { should ensure_length_of(:description).is_at_most(360) }

  it "has a friendly id" do
    expect(category.to_param).to eq(category.slug)
  end

  it "audits changes on full_name"
  it "audits changes on description"

  it { should have_many(:categorizations) }
  it { should have_many(:repos).through(:categorizations) }

  it { should have_many(:language_classifications) }
  it { should have_many(:languages).through(:language_classifications) }

  it { should have_many(:link_relationships) }
  it { should have_many(:links).through(:link_relationships) }

  it { should have_many(:category_relationships) }
  it { should have_many(:related_categories).through(:category_relationships) }

  it { should have_many(:reverse_category_relationships) }
  it { should have_many(:reverse_related_categories).through(:reverse_category_relationships) }

  context "with related categories" do
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

  describe "#save" do
    it "assigns stars from repos"
    it "assigns score from repos"
    it "assigns languages from categories"
  end
end
