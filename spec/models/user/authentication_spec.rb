require 'spec_helper'

describe User::Authentication do
  subject(:authentication) { build(:user_authentication) }

  describe 'validations' do
    before { authentication.save }
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:provider) }
    it { should validate_presence_of(:uid) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end
end
