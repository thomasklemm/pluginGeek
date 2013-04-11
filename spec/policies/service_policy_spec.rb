require 'spec_helper'

describe ServicePolicy do
  subject { ServicePolicy }

  let(:service) { Fabricate.build(:service) }
  let(:staff)   { Fabricate.build(:user, staff: true) }
  let(:user)    { Fabricate.build(:user) }
  let(:guest)   { nil }

  context "staff" do
    it { should permit_policy(staff, service, :index?) }
    it { should permit_policy(staff, service, :show?) }
    it { should permit_policy(staff, service, :new?) }
    it { should permit_policy(staff, service, :create?) }
    it { should permit_policy(staff, service, :edit?) }
    it { should permit_policy(staff, service, :update?) }
    it { should permit_policy(staff, service, :destroy?) }
  end

  context "user" do
    it { should permit_policy(user, service, :index?) }
    it { should_not permit_policy(user, service, :show?) }
    it { should_not permit_policy(user, service, :new?) }
    it { should_not permit_policy(user, service, :create?) }
    it { should_not permit_policy(user, service, :edit?) }
    it { should_not permit_policy(user, service, :update?) }
    it { should_not permit_policy(user, service, :destroy?) }
  end

  context "guest" do
    it { should permit_policy(guest, service, :index?) }
    it { should_not permit_policy(guest, service, :show?) }
    it { should_not permit_policy(guest, service, :new?) }
    it { should_not permit_policy(guest, service, :create?) }
    it { should_not permit_policy(guest, service, :edit?) }
    it { should_not permit_policy(guest, service, :update?) }
    it { should_not permit_policy(guest, service, :destroy?) }
  end
end
