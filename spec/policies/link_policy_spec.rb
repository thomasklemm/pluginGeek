require 'spec_helper'

describe LinkPolicy do
  subject { LinkPolicy }

  let(:link)     { Fabricate.build(:link) }
  let(:submitted_link) { Fabricate.build(:link, submitter: user) }

  let(:staff)    { Fabricate.build(:user, staff: true) }
  let(:user)     { Fabricate.build(:user) }
  let(:guest)    { nil }

  context "staff" do
    it { should permit_policy(staff, link, :new?) }
    it { should permit_policy(staff, link, :create?) }
    it { should permit_policy(staff, link, :edit?) }
    it { should permit_policy(staff, link, :update?) }
    it { should permit_policy(staff, link, :destroy?) }
  end

  context "user" do
    it { should permit_policy(user, link, :new?) }
    it { should permit_policy(user, link, :create?) }
    it { should permit_policy(user, link, :edit?) }
    it { should permit_policy(user, link, :update?) }
    it { should permit_policy(user, submitted_link, :destroy?) }
    it { should_not permit_policy(user, link, :destroy?) }
  end

  context "guest" do
    it { should_not permit_policy(guest, link, :index?) }
    it { should_not permit_policy(guest, link, :show?) }
    it { should_not permit_policy(guest, link, :new?) }
    it { should_not permit_policy(guest, link, :create?) }
    it { should_not permit_policy(guest, link, :edit?) }
    it { should_not permit_policy(guest, link, :update?) }
    it { should_not permit_policy(guest, link, :destroy?) }
  end
end
