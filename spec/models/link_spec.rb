require 'spec_helper'

describe Link do
  subject(:link) { build(:link) }

  describe 'validations' do
    before { link.save }
    it { should validate_presence_of(:url) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:submitter) }
  end

  describe 'associations' do
    it { should belong_to(:submitter).class_name('User') }
    it { should have_many(:repos).through(:link_relationships) }
    it { should have_many(:categories).through(:link_relationships) }
    it { should have_many(:link_relationships).dependent(:destroy) }
  end
end
