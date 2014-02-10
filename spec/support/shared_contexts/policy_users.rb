# Pundit policy users
#
shared_context "policy_users" do
  let(:moderator) { Fabricate.build(:user, moderator: true) }
  let(:user)      { Fabricate.build(:user) }
  let(:guest)     { nil }
end