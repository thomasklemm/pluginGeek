require 'spec_helper'

describe Repo do
  subject(:repo) { Fabricate.build(:repo) }
  it { should be_valid }

  let(:first_child)  { Fabricate.build(:repo) }
  let(:second_child) { Fabricate.build(:repo) }

  let(:first_parent)  { Fabricate.build(:repo) }
  let(:second_parent) { Fabricate.build(:repo) }

  let(:first_language) { Fabricate.build(:language) }
  let(:second_language) { Fabricate.build(:language) }

  let(:first_category)  { Fabricate.build(:category, full_name: "Testing (Ruby)") }
  let(:second_category) { Fabricate.build(:category, full_name: "Testing (Javascript)") }

  it { should validate_presence_of(:full_name) }
  it { should validate_uniqueness_of(:full_name) }

  it "has a friendly id using the full_name" do
    expect(repo.to_param).to eq(repo.full_name)
  end

  it { should ensure_length_of(:description).is_at_most(360) }

  describe "named scopes" do
    describe ".order_by_score" do
      it "returns repos ordered by score" do
        expect(Repo.order_by_score.to_sql).to match(/ORDER BY repos.score DESC/)
      end
    end

    describe ".order_by_name" do
      it "returns repos ordered by full_name" do
        expect(Repo.order_by_name.to_sql).to match(/ORDER BY repos.full_name ASC/)
      end
    end

    describe ".ids_and_full_names" do
      it "selects only relevant fields" do
        expect(Repo.ids_and_full_names.to_sql).to match(/SELECT id, full_name FROM \"repos\"/)
      end

      it "orders repos by score" do
        expect(Repo.ids_and_full_names.to_sql).to match(/ORDER BY repos.score DESC/)
      end
    end

    describe ".ids_and_full_names_without(repo)" do
      before { repo.save }

      it "selects only relevant fields" do
        expect(Repo.ids_and_full_names_without(repo).to_sql).to match(/SELECT id, full_name FROM \"repos\"/)
      end

      it "orders repos by score" do
        expect(Repo.ids_and_full_names_without(repo).to_sql).to match(/ORDER BY repos.score DESC/)
      end

      it "excludes the given repo" do
        expect(Repo.ids_and_full_names_without(repo)).to_not include(repo)
      end
    end
  end

  describe "#stars" do
    it "returns the stars count" do
      repo.stars = 100
      expect(repo.stars).to eq(100)
    end

    it "returns 0 when missing" do
      expect(repo.stars).to eq(0)
    end
  end

  describe "#score" do
    it "returns the score" do
      repo.score = 100
      expect(repo.score).to eq(100)
    end

    it "returns 0 when missing" do
      expect(repo.score).to eq(0)
    end
  end

  it { should have_many(:parent_child_relationships).class_name('RepoRelationship').dependent(:destroy) }
  it { should have_many(:parents).through(:parent_child_relationships) }

  it { should have_many(:child_parent_relationships).class_name('RepoRelationship').dependent(:destroy) }
  it { should have_many(:children).through(:child_parent_relationships) }

  describe "#parents_and_children" do
    before do
      repo.save
      repo.children = [first_child]
      repo.parents = [first_parent]
    end

    it "return parents and children" do
      expect(repo.parents_and_children).to be_an Array
      expect(repo.parents_and_children).to have(2).items
      expect(repo.parents_and_children).to match_array([first_parent, first_child])
    end
  end

  it { should have_many(:categorizations).dependent(:destroy) }
  it { should have_many(:categories).through(:categorizations) }

  it { should have_many(:language_classifications).dependent(:destroy) }
  it { should have_many(:languages).through(:language_classifications) }

  it { should have_many(:link_relationships).dependent(:destroy) }
  it { should have_many(:links).through(:link_relationships) }

  describe "#child_list" do
    before { repo.children = [first_child, second_child] }

    it "returns a list of children" do
      expect(repo.child_list).to be_present
      expect(repo.child_list).to be_a String
      expect(repo.child_list.split(", ")).to match_array([first_child.full_name, second_child.full_name])
    end
  end

  describe "#language_list" do
    before { repo.languages = [first_language, second_language] }

    it "returns a list of languages" do
      expect(repo.language_list).to be_present
      expect(repo.language_list).to be_a String
      expect(repo.language_list.split(", ")).to match_array([first_language.name, second_language.name])
    end
  end

  describe "#category_list" do
    before { repo.categories = [first_category, second_category] }

    it "returns a list of categories" do
      expect(repo.category_list).to be_present
      expect(repo.category_list).to be_a String
      expect(repo.category_list.split(", ")).to match_array([first_category.full_name, second_category.full_name])
    end
  end

  describe "#category_list=" do
      let!(:category) { Fabricate(:category, full_name: "Testing (Ruby)") }

      it "assigns existing categories when given" do
        repo.category_list = "Testing (Ruby)"
        expect(repo.categories).to eq([category])
      end

      it "creates new categories when nescessary" do
        repo.category_list = "News (Ruby)"
        expect(repo.category_list).to eq("News (Ruby)")
      end

      it "takes a mix of both existing and new categories" do
        repo.category_list = "Testing (Ruby), News (Ruby)"
        expect(repo.category_list.split(", ")).to match_array(["Testing (Ruby)", "News (Ruby)"])
      end
  end

  describe "#last_updated" do
    it "returns the time span that has passed since the current github_updated_at" do
      Timecop.freeze
      repo.github_updated_at = 1.day.ago
      expect(repo.last_updated).to eq(1.day)
      Timecop.return
    end
  end

  describe "#github_updated_at" do
    it "returns the last time the repo was updated on Github" do
      Timecop.freeze
      repo.github_updated_at = 1.day.ago
      expect(repo.github_updated_at).to eq(1.day.ago.utc)
      expect(repo.github_updated_at).to be_utc
      Timecop.return
    end

    it "returns a default fallback of a few years ago" do
      Timecop.freeze
      expect(repo.github_updated_at).to eq(2.years.ago.utc)
      expect(repo.github_updated_at).to be_utc
      Timecop.return
    end
  end

  describe "#update_succeeded!" do
    before do
      repo.save
      @result = repo.update_succeeded!
    end

    it "flags the repo as successfully updated" do
      expect(repo).to be_update_success
    end

    it "returns true" do
      expect(@result).to be_true
    end
  end

  describe "#update_failed!" do
    context "repo is a new record" do
      before { @result = repo.update_failed! }

      it "assigns a false value to update_success" do
        expect(repo).to be_new_record
        expect(repo).to_not be_update_success
      end

      it "returns false" do
        expect(@result).to be_false
      end
    end

    context "repo is a persisted record" do
      before do
        repo.save
        @result = repo.update_failed!
      end

      it "sets the update_success field in the database" do
        repo.reload
        expect(repo).to_not be_update_success
      end

      it "returns false" do
        expect(@result).to be_false
      end
    end
  end

  describe "#retrieve_from_github" do
    it "updates the repo with the current Github data" do
      updater = RepoUpdater.new
      RepoUpdater.expects(:new).returns(updater)
      updater.expects(:update).with(repo.full_name)

      repo.retrieve_from_github
    end
  end

  describe "#save" do
    describe "assigns score before save" do
      before do
        Timecop.freeze
        repo.stars = 99
        repo.staff_pick = true
        repo.github_updated_at = Time.current
        repo.save
        @score = repo.score
        Timecop.return
      end

      it "assigns score" do
        expect(@score).to eq(250)
      end
    end

    describe "assigns languages from categories before save" do
      before do
        Fabricate(:language, name: "Ruby")
        Fabricate(:language, name: "Javascript")
        first_category.save
        second_category.save
        repo.categories = [first_category, second_category]
        repo.save
      end

      it "assigns languages" do
        expect(repo.language_list.split(", ")).to match_array(%w(Ruby Javascript))
      end
    end
  end

  describe "#update_categories" do
    let(:category) { Fabricate(:category) }

    it "updates associated categories" do
      repo.categories << category
      category.expects(:save)
      repo.send(:update_categories)
    end
  end
end
