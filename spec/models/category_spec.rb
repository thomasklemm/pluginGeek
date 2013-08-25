require 'spec_helper'

describe Category do
  subject(:category) { Fabricate.build(:category) }
  it { should be_valid }

  it { should validate_presence_of(:full_name) }
  it { should ensure_length_of(:description).is_at_most(360) }

  it { should have_many(:categorizations).dependent(:destroy) }
  it { should have_many(:repos).through(:categorizations) }

  it { should have_many(:language_classifications).dependent(:destroy) }
  it { should have_many(:languages).through(:language_classifications) }

  it { should have_many(:link_relationships).dependent(:destroy) }
  it { should have_many(:links).through(:link_relationships) }

  it { should have_many(:category_relationships).dependent(:destroy) }
  it { should have_many(:related_categories).through(:category_relationships) }

  it { should have_many(:reverse_category_relationships).dependent(:destroy) }
  it { should have_many(:reverse_related_categories).through(:reverse_category_relationships) }

  it { should have_many(:service_categorizations).dependent(:destroy) }
  it { should have_many(:services).through(:service_categorizations) }

  it "has a friendly id using the full_name" do
    category.save
    expect(category.to_param).to eq(category.full_name.parameterize)
  end

  it "preserves a history of slugs" do
    category.full_name = "Old name (Ruby)"
    category.save
    old_slug = category.slug

    category.full_name = "New name (Ruby)"
    category.save
    new_slug = category.slug

    expect(new_slug).to_not eq(old_slug)
    expect(Category.find(old_slug)).to eq(category)
    expect(Category.find(new_slug)).to eq(category)
  end

  describe "named scopes" do
    describe ".order_by_score" do
      it "returns categories ordered by score" do
        expect(Category.order_by_score.to_sql).to match(/ORDER BY categories.score DESC/)
      end
    end

    describe ".order_by_name" do
      it "returns categories ordered by full_name" do
        expect(Category.order_by_name.to_sql).to match(/ORDER BY categories.full_name ASC/)
      end
    end

    describe ".ids_and_full_names" do
      it "selects only relevant fields" do
        expect(Category.ids_and_full_names.to_sql).to match(/SELECT id, full_name FROM \"categories\"/)
      end

      it "orders categories by score" do
        expect(Category.ids_and_full_names.to_sql).to match(/ORDER BY categories.score DESC/)
      end
    end

    describe ".ids_and_full_names_without(category)" do
      before { category.save }

      it "selects only relevant fields" do
        expect(Category.ids_and_full_names_without(category).to_sql).to match(/SELECT id, full_name FROM \"categories\"/)
      end

      it "orders categories by score" do
        expect(Category.ids_and_full_names_without(category).to_sql).to match(/ORDER BY categories.score DESC/)
      end

      it "excludes the given category" do
        expect(Category.ids_and_full_names_without(category)).to_not include(category)
      end
    end

    describe ".featured(count)" do
      it "returns only featured categories" do
        category = Fabricate(:category, featured: true)
        Fabricate(:category)
        expect(Category.featured(2)).to eq([category])
      end

      it "returns the specified number of categories" do
        2.times { Fabricate(:category, featured: true) }
        expect(Category.featured(1)).to have(1).item
      end

      it "randomizes the categories and order" do
        5.times { Fabricate(:category, featured: true) }
        featured_one = Category.featured(3)
        featured_two = Category.featured(3)
        expect(featured_one).to_not eq(featured_two)
      end
    end
  end

  describe "#stars" do
    it "returns the stars count" do
      category.stars = 100
      expect(category.stars).to eq(100)
    end

    it "returns 0 when missing" do
      expect(category.stars).to eq(0)
    end
  end

  describe "#score" do
    it "returns the score" do
      category.score = 100
      expect(category.score).to eq(100)
    end

    it "returns 0 when missing" do
      expect(category.score).to eq(0)
    end
  end

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

  describe "#extended_links" do
    let(:repo) { Fabricate(:repo) }
    let(:link) { Fabricate(:link) }
    let(:link_via_repo) { Fabricate(:link) }

    before do
      category.repos << repo
      category.links << link
      repo.links     << link_via_repo
      category.save
    end

    it "returns links of the category and it's associated repos" do
      expect(category.extended_links).to match_array([link, link_via_repo])
    end
  end


  describe "#save" do
    let(:category) { Fabricate(:category, full_name: "Category (Ruby/UnknownLanguage)") }
    let(:repo)     { Fabricate(:repo, stars: 100, score: 200) }

    before do
      Fabricate(:language, name: 'Ruby')

      category.repos << repo
      category.save
    end

    it "assigns stars from repos" do
      expect(category.stars).to eq 100
    end

    it "assigns score from repos" do
      expect(category.score).to eq(repo.score)
    end

    it "assigns known languages from full_name" do
      expect(category.languages.map(&:name)).to match_array %w(Ruby)
    end
  end

  describe "#assign_languages before saving" do
    before do
      web = Fabricate(:language, name: 'Web')
      Fabricate(:language, name: 'Ruby', parent: web )

      mobile = Fabricate(:language, name: 'Mobile')
      Fabricate(:language, name: 'iOS', parent: mobile)
    end

    let!(:category) { Fabricate(:category, full_name: "Category(Web/Mobile)") }

    it "assigns additional web languages if language 'Web' is assigned" do
      expect(category.languages.map(&:name)).to include('Ruby')
    end

    it "assigns additional mobile languages if language 'Mobile' is assigned" do
      expect(category.languages.map(&:name)).to include('iOS')
    end
  end

  describe ".expire_all" do
    it "expires all categories" do
      Timecop.freeze
      category = Fabricate(:category, created_at: 1.day.ago, updated_at: 1.day.ago)
      Category.expire_all
      expect(category.reload.updated_at).to eq(Time.current)
      Timecop.return
    end
  end

  describe "#expire_repos" do
    it "expires associated repos" do
      Timecop.freeze
      category.repos.expects(:update_all).with(updated_at: Time.current)
      category.send(:expire_repos)
      Timecop.return
    end
  end

  describe "#expire_languages" do
    it "expires associated languages" do
      Timecop.freeze
      category.languages.expects(:update_all).with(updated_at: Time.current)
      category.send(:expire_languages)
      Timecop.return
    end
  end
end
