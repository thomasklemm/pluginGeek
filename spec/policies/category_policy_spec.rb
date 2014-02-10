require 'spec_helper'

describe CategoryPolicy do
  include_context "policy_users"
  subject { CategoryPolicy }
  let(:category) { Fabricate.build(:category) }

  context "moderator" do
    it { should permit_policy(moderator, category, :show?) }
    it { should permit_policy(moderator, category, :new?) }
    it { should permit_policy(moderator, category, :create?) }
    it { should permit_policy(moderator, category, :edit?) }
    it { should permit_policy(moderator, category, :update?) }
    it { should permit_policy(moderator, category, :destroy?) }
  end

  context "user" do
    it { should permit_policy(user, category, :show?) }
    it { should_not permit_policy(user, category, :new?) }
    it { should_not permit_policy(user, category, :create?) }
    it { should permit_policy(user, category, :edit?) }
    it { should permit_policy(user, category, :update?) }
    it { should_not permit_policy(user, category, :destroy?) }
  end

  context "guest" do
    it { should permit_policy(guest, category, :show?) }
    it { should_not permit_policy(guest, category, :new?) }
    it { should_not permit_policy(guest, category, :create?) }
    it { should_not permit_policy(guest, category, :edit?) }
    it { should_not permit_policy(guest, category, :update?) }
    it { should_not permit_policy(guest, category, :destroy?) }
  end
end
