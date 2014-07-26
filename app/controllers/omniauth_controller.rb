class OmniauthController < Devise::OmniauthCallbacksController
  skip_before_action :store_location

  # Handle omniauth callbacks from Github
  def github
    # Login or create user from Github
    @user = User.find_or_create_user_from_github(auth_hash)

    if @user.persisted?
      # Authentication succeeded
      @user.remember_me!
      flash.notice = "Hi, #{@user.login}. How are you?"
      sign_in_and_redirect @user
    else
      # Authentication failed
      flash.alert = 'Authenticating with Github failed. ' \
        'Will you try again? '
      redirect_to root_url
    end
  end

  # User clicked deny on authorization screen with Github
  def failure
    flash.alert = 'Authenticating with Github failed. ' \
      'Will you try again? ' \
      'For you to contribute, we need to know who you are. '
    redirect_to root_path
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
