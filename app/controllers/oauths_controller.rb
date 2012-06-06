class OauthsController < ApplicationController

  # Sends the user on a trip to the provider
  #   and after authorizing there back to the callback url.
  def oauth
    login_at(params[:provider])
  end

  def callback
    provider = params[:provider]

    if @user = login_from(provider)

      # known user
      cookies.permanent.signed[:remember_me_token] = auto_login(@user, true) # remember login
      redirect_back_or_to root_path, notice: "Logged in from #{ provider.titleize }!"

    else
      # new user
      begin
        # create user
        @user = create_from(provider)
        reset_session # protect from session fixation attack
        cookies.permanent.signed[:remember_me_token] = auto_login(@user, true) # remember login
        redirect_back_or_to root_path, notice: "Logged in from #{ provider.titleize }!"
      rescue
        # oauth failed
        redirect_back_or_to root_path, alert: "Failed to login from #{ provider.titleize }!"
      end

    end
  end
end
