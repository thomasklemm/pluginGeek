require 'spec_helper'

describe LinkPolicy do
  include_context "policy_users"
  subject { LinkPolicy }
  let(:link) { Fabricate.build(:link) }
  let(:submitted_link) { Fabricate.build(:link, submitter: user) }

  context "moderator" do
    it { should_not permit_policy(moderator, link, :show?) }
    it { should permit_policy(moderator, link, :new?) }
    it { should permit_policy(moderator, link, :create?) }
    it { should permit_policy(moderator, link, :edit?) }
    it { should permit_policy(moderator, link, :update?) }
    it { should permit_policy(moderator, link, :destroy?) }
  end

  context "user" do
    it { should_not permit_policy(user, link, :show?) }
    it { should permit_policy(user, link, :new?) }
    it { should permit_policy(user, link, :create?) }
    it { should permit_policy(user, link, :edit?) }
    it { should permit_policy(user, link, :update?) }
    it { should permit_policy(user, submitted_link, :destroy?) }
    it { should_not permit_policy(user, link, :destroy?) }
  end

  context "guest" do
    it { should_not permit_policy(guest, link, :show?) }
    it { should_not permit_policy(guest, link, :new?) }
    it { should_not permit_policy(guest, link, :create?) }
    it { should_not permit_policy(guest, link, :edit?) }
    it { should_not permit_policy(guest, link, :update?) }
    it { should_not permit_policy(guest, link, :destroy?) }
  end
end
