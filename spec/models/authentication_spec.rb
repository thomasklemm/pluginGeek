require 'spec_helper'

describe Authentication do
  subject { Fabricate.build(:authentication) }

  describe 'validations' do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:provider) }
    it { should validate_presence_of(:uid) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end
end
