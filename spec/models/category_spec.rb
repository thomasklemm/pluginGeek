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

  it { should have_many(:related_categories).through(:category_relationships) }
  it { should have_many(:category_relationships).dependent(:destroy) }

  it { should have_many(:reverse_related_categories).through(:reverse_category_relationships) }
  it { should have_many(:reverse_category_relationships).dependent(:destroy) }

  it { should have_many(:services).through(:service_categorizations) }
  it { should have_many(:service_categorizations).dependent(:destroy) }
end
