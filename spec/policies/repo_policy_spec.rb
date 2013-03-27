require 'spec_helper'

describe RepoPolicy do
  subject { RepoPolicy }

  let(:repo)     { Fabricate.build(:repo) }
  let(:staff)    { Fabricate.build(:user, staff: true) }
  let(:user)     { Fabricate.build(:user) }
  let(:guest)    { nil }

  context "staff" do
    it { should permit_policy(staff, repo, :index?) }
    it { should permit_policy(staff, repo, :show?) }
    it { should permit_policy(staff, repo, :new?) }
    it { should permit_policy(staff, repo, :create?) }
    it { should permit_policy(staff, repo, :edit?) }
    it { should permit_policy(staff, repo, :update?) }
    it { should permit_policy(staff, repo, :destroy?) }
  end

  context "user" do
    it { should permit_policy(user, repo, :index?) }
    it { should permit_policy(user, repo, :show?) }
    it { should permit_policy(user, repo, :new?) }
    it { should permit_policy(user, repo, :create?) }
    it { should permit_policy(user, repo, :edit?) }
    it { should permit_policy(user, repo, :update?) }
    it { should_not permit_policy(user, repo, :destroy?) }
  end

  context "guest" do
    it { should permit_policy(guest, repo, :index?) }
    it { should permit_policy(guest, repo, :show?) }
    it { should_not permit_policy(guest, repo, :new?) }
    it { should_not permit_policy(guest, repo, :create?) }
    it { should_not permit_policy(guest, repo, :edit?) }
    it { should_not permit_policy(guest, repo, :update?) }
    it { should_not permit_policy(guest, repo, :destroy?) }
  end
end
