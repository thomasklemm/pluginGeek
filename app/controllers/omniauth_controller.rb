class OmniauthController < Devise::OmniauthCallbacksController
  # Handle omniauth callbacks from github
  def github
    # Login or create user from github
    omniauth = request.env['omniauth.auth']
    @user = User.find_or_create_user_from_github(omniauth)

    # Did our user just authenticate successfully?
    if @user.persisted?
      flash.notice = "Hi, #{ @user.name }. Enjoy pluginGeek!"
      sign_in_and_redirect_user
    else
      # Authentication failed!
      flash.alert = "Authentication failed. Please email me at thomas@plugingeek.com."
      redirect_to root_url
    end
  end

  private

  def sign_in_and_redirect_user
    # Persist login
    @user.remember_me!

    # Redirect user to stored path he is trying to access
    # or after_sign_in_path if none is present
    sign_in_and_redirect @user, event: :authentication
  end
end
