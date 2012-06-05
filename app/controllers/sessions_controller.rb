
class SessionsController < ApplicationController
  # get /login
  def new
  end

  # post /sessions
  def create
    user = login(params[:email], params[:password], params[:remember_me])
    if user
      redirect_back_or_to root_url, notice: 'Logged in!'
    else
      flash.now.alert = 'Email or password was invalid'
      render :new
    end
  end

  # delete /sessions
  def destroy
    logout
    redirect_to root_url, notice: 'Logged out!'
  end
end
