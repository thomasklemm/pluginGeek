require 'spec_helper'

describe ApplicationPolicy do
  include_context "policy_users"
  subject { ApplicationPolicy }
  let(:record) { nil }

  context "moderator" do
    it { should_not permit_policy(moderator, record, :index?) }
    it { should_not permit_policy(moderator, record, :show?) }
    it { should_not permit_policy(moderator, record, :new?) }
    it { should_not permit_policy(moderator, record, :create?) }
    it { should_not permit_policy(moderator, record, :edit?) }
    it { should_not permit_policy(moderator, record, :update?) }
    it { should_not permit_policy(moderator, record, :destroy?) }
  end

  context "user" do
    it { should_not permit_policy(user, record, :index?) }
    it { should_not permit_policy(user, record, :show?) }
    it { should_not permit_policy(user, record, :new?) }
    it { should_not permit_policy(user, record, :create?) }
    it { should_not permit_policy(user, record, :edit?) }
    it { should_not permit_policy(user, record, :update?) }
    it { should_not permit_policy(user, record, :destroy?) }
  end

  context "guest" do
    it { should_not permit_policy(guest, record, :index?) }
    it { should_not permit_policy(guest, record, :show?) }
    it { should_not permit_policy(guest, record, :new?) }
    it { should_not permit_policy(guest, record, :create?) }
    it { should_not permit_policy(guest, record, :edit?) }
    it { should_not permit_policy(guest, record, :update?) }
    it { should_not permit_policy(guest, record, :destroy?) }
  end
end
