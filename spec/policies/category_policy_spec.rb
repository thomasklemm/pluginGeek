require 'spec_helper'

describe CategoryPolicy do
  subject { CategoryPolicy }

  let(:category) { Fabricate.build(:category) }
  let(:staff)    { Fabricate.build(:user, staff: true) }
  let(:user)     { Fabricate.build(:user) }
  let(:guest)    { nil }

  context "staff" do
    it { should permit_policy(staff, category, :index?) }
    it { should permit_policy(staff, category, :show?) }
    it { should permit_policy(staff, category, :edit?) }
    it { should permit_policy(staff, category, :update?) }
    it { should permit_policy(staff, category, :destroy?) }
  end

  context "user" do
    it { should permit_policy(user, category, :index?) }
    it { should permit_policy(user, category, :show?) }
    it { should permit_policy(user, category, :edit?) }
    it { should permit_policy(user, category, :update?) }
    it { should_not permit_policy(user, category, :destroy?) }
  end

  context "guest" do
    it { should permit_policy(guest, category, :index?) }
    it { should permit_policy(guest, category, :show?) }
    it { should_not permit_policy(guest, category, :edit?) }
    it { should_not permit_policy(guest, category, :update?) }
    it { should_not permit_policy(guest, category, :destroy?) }
  end
end
