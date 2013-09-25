# An authenticated controller action
#
# Actions that are protected by Devise's
# before_action :authenticate_user!
#
shared_examples_for "an authenticated controller action" do
  it { should redirect_to(login_path) }
  it { should set_the_flash.to("You need to sign in or sign up before continuing.") }
end
