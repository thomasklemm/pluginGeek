require 'spec_helper'

describe Link do
  subject(:link) { Fabricate.build(:link) }
  it { should be_valid }

  it { should validate_presence_of(:url) }
  it { should validate_presence_of(:title) }

  it { should belong_to(:submitter).class_name('User') }
  it { should validate_presence_of(:submitter) }

  it { should have_many(:repos).through(:link_relationships) }
  it { should have_many(:categories).through(:link_relationships) }
  it { should have_many(:link_relationships).dependent(:destroy) }
end
