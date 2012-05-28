class UsersController < ApplicationController
  def show
    login = login_from_params
    @user = User.find_by_login(login)
    @repos = Repo.find_by_owner(login)
  end

  def new
    login = login_from_params
    @user = User.find_by_login(login)
    @repos = Repo.find_by_owner(login)

    github = Github.new
    @repos_github = github.repos.list_repos(user: login)
  end

  def create

  end

protected
  
  def login_from_params(login = params[:owner])
    login
  end

end
