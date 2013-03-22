require 'spec_helper'

describe Repo do
  subject(:repo) { Fabricate.build(:repo) }
  it { should be_valid }

  let(:first_child)  { Fabricate.build(:repo) }
  let(:second_child) { Fabricate.build(:repo) }

  let(:first_parent)  { Fabricate.build(:repo) }
  let(:second_parent) { Fabricate.build(:repo) }

  it { should validate_presence_of(:full_name) }
  it { should validate_uniqueness_of(:full_name) }

  it "uses the full_name as a friendly id"

  it { should ensure_length_of(:description).is_at_most(360) }

  it "audits changes on description"

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

  it { should have_many(:categorizations) }
  it { should have_many(:categories).through(:categorizations) }

  it { should have_many(:language_classifications) }
  it { should have_many(:languages).through(:language_classifications) }

  it { should have_many(:link_relationships) }
  it { should have_many(:links).through(:link_relationships) }


  describe "#child_list" do
    before do
      repo.save
      repo.children = [first_child, second_child]
    end

    it "returns a list of children" do
      expect(repo.child_list).to be_a String
      expect(repo.child_list.split(", ")).to match_array([first_child.full_name, second_child.full_name])
    end
  end



end
