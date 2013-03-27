require 'spec_helper'

describe OmniauthController, "#github" do
  let(:user) { Fabricate(:user, name: 'Thomas') }

  before do
    auth_hash = { uid: 1 }
    request.env['devise.mapping'] = Devise.mappings[:user]
    request.env['omniauth.auth'] = auth_hash

    User.expects(:find_or_create_user_from_github).with(auth_hash).returns(user)

    get :github
  end

  it "signs the user in" do
    expect(controller.current_user).to eq(user)
  end

  it "redirects the user" do
    expect(response).to redirect_to(root_path)
  end

  it { should set_the_flash.to(/#{ user.name }/) }
end
