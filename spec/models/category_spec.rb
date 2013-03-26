# == Schema Information
#
# Table name: categories
#
#  created_at     :datetime         not null
#  description    :text
#  draft          :boolean          default(TRUE)
#  full_name      :text             not null
#  id             :integer          not null, primary key
#  knight_score   :integer          default(0)
#  language_names :text
#  repo_names     :text
#  slug           :text             not null
#  stars          :integer          default(0)
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_categories_on_knight_score  (knight_score)
#  index_categories_on_slug          (slug) UNIQUE
#

require 'spec_helper'

describe Category do
  subject(:category) { Fabricate.build(:category) }
  it { should be_valid }

  it { should validate_presence_of(:full_name) }
  it { should ensure_length_of(:description).is_at_most(360) }

  it "has a friendly id using the full_name" do
    category.save
    expect(category.to_param).to eq(category.full_name.parameterize)
  end

  it "preserves a history of slugs"

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
    let(:category) { Fabricate.build(:category, full_name: "Category (Ruby/Javascript)") }
    let(:repo)     { Fabricate.build(:repo, stars: 100, knight_score: 200) }

    before do
      Fabricate(:language, name: 'Ruby')

      category.repos << repo
      category.save
    end

    it "assigns stars from repos" do
      expect(category.stars).to eq 100
    end

    it "assigns score from repos" do
      expect(category.knight_score).to eq 200
    end

    it "assigns languages from full_name" do
      expect(category.languages.map(&:name)).to match_array %w(Ruby)
    end
  end
end
