describe ApplicationPolicy do
  subject { ApplicationPolicy }

  let(:record)   { nil }
  let(:staff)    { Fabricate.build(:user, staff: true) }
  let(:user)     { Fabricate.build(:user) }
  let(:guest)    { nil }

  context "staff" do
    it { should_not permit_policy(staff, record, :index?) }
    it { should_not permit_policy(staff, record, :show?) }
    it { should_not permit_policy(staff, record, :new?) }
    it { should_not permit_policy(staff, record, :create?) }
    it { should_not permit_policy(staff, record, :edit?) }
    it { should_not permit_policy(staff, record, :update?) }
    it { should_not permit_policy(staff, record, :destroy?) }
    it { should permit_policy(staff, record, :staff_action?) }
  end

  context "user" do
    it { should_not permit_policy(user, record, :index?) }
    it { should_not permit_policy(user, record, :show?) }
    it { should_not permit_policy(user, record, :new?) }
    it { should_not permit_policy(user, record, :create?) }
    it { should_not permit_policy(user, record, :edit?) }
    it { should_not permit_policy(user, record, :update?) }
    it { should_not permit_policy(user, record, :destroy?) }
    it { should_not permit_policy(user, record, :staff_action?) }
  end

  context "guest" do
    it { should_not permit_policy(guest, record, :index?) }
    it { should_not permit_policy(guest, record, :show?) }
    it { should_not permit_policy(guest, record, :new?) }
    it { should_not permit_policy(guest, record, :create?) }
    it { should_not permit_policy(guest, record, :edit?) }
    it { should_not permit_policy(guest, record, :update?) }
    it { should_not permit_policy(guest, record, :destroy?) }
    it { should_not permit_policy(guest, record, :staff_action?) }
  end
end
