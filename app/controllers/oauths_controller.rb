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
      #   remember login
      cookies.permanent.signed[:remember_me_token] = auto_login(@user, true)
      redirect_back_or_to root_path, notice: "Hi, #{ @user.name }. Welcome back to Knight.io. You definitely rock!"

    else
      # new user
      begin
        # create user
        @user = create_from(provider)
        reset_session # protect from session fixation attack
        # remember login
        cookies.permanent.signed[:remember_me_token] = auto_login(@user, true)
        redirect_back_or_to root_path, notice: "Hi, #{ @user.name }. Welcome to Knight.io. You rock!"
      rescue
        # oauth failed
        redirect_back_or_to root_path, alert: "Failed to sign up or log in from #{ provider.titleize }!"
      end

    end
  end
end
