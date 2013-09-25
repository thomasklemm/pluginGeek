class OmniauthController < Devise::OmniauthCallbacksController
  # Handle omniauth callbacks from github
  def github
    # Login or create user from github
    @user = User.find_or_create_user_from_github(auth_hash)

    if @user.persisted?
      # Authentication succeeded
      @user.remember_me!
      flash.notice = "Hi, #{ @user.name }. Enjoy pluginGeek!"
      sign_in_and_redirect @user
    else
      # Authentication failed
      flash.alert = "Login from Github failed. Please email me at thomas@plugingeek.com."
      redirect_to root_url
    end
  end

  # User clicked deny on authorization screen with Github
  def failure
    flash.alert = "Authenticating with Github failed."
    redirect_to root_path
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
