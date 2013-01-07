class OmniauthController < Devise::OmniauthCallbacksController
  # Handle callbacks from github
  def github
    # Login or create user from github
    omniauth = request.env['omniauth.auth']
    @user = User.find_or_create_user_from_github(omniauth)

    # Did our user just authenticate successfully?
    if @user.persisted?
      flash.notice = "Hello, #{ @user.name}. Welcome at pluginGeek."
      # Persist login
      @user.remember_me!
      sign_in_and_redirect @user, event: :authentication
    else
      # Authentication failed!
      flash.alert = "Authentication failed. Please email me at thomas@plugingeek.com."
      redirect_to root_url
    end
  end
end
