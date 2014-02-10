require 'spec_helper'

describe RepoPolicy do
  include_context "policy_users"
  subject { RepoPolicy }
  let(:repo) { Fabricate.build(:repo) }

  context "moderator" do
    it { should permit_policy(moderator, repo, :show?) }
    it { should permit_policy(moderator, repo, :new?) }
    it { should permit_policy(moderator, repo, :create?) }
    it { should permit_policy(moderator, repo, :edit?) }
    it { should permit_policy(moderator, repo, :update?) }
    it { should permit_policy(moderator, repo, :destroy?) }
  end

  context "user" do
    it { should permit_policy(user, repo, :show?) }
    it { should permit_policy(user, repo, :new?) }
    it { should permit_policy(user, repo, :create?) }
    it { should permit_policy(user, repo, :edit?) }
    it { should permit_policy(user, repo, :update?) }
    it { should_not permit_policy(user, repo, :destroy?) }
  end

  context "guest" do
    it { should permit_policy(guest, repo, :show?) }
    it { should permit_policy(guest, repo, :new?) }
    it { should_not permit_policy(guest, repo, :create?) }
    it { should_not permit_policy(guest, repo, :edit?) }
    it { should_not permit_policy(guest, repo, :update?) }
    it { should_not permit_policy(guest, repo, :destroy?) }
  end
end
