class OmniauthController < Devise::OmniauthCallbacksController
  skip_before_action :store_location

  # Handle omniauth callbacks from Github
  def github
    # Login or create user from Github
    @user = User.find_or_create_user_from_github(auth_hash)

    if @user.persisted?
      # Authentication succeeded
      @user.remember_me!
      flash.notice = "Hey #{@user.login}. Great to have you."
      sign_in_and_redirect @user
    else
      # Authentication failed
      flash.alert = "Ouch. Github login failed. Would you try again?"
      redirect_to root_url
    end
  end

  # User clicked deny on authorization screen with Github
  def failure
    flash.alert = "That didn't work. Would you try again?
                   We only require you to grant access to public information,
                   and we'll not sell it or anything. We're no jerks, guaranteed."
    redirect_to root_path
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
