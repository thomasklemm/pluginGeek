class UsersController < ApplicationController
  def show
    login = login_from_params

    @user = User.find_or_initialize_by_login(login)
    @user.new_record? and return redirect_to action: "create"

    @repos = Repo.find_all_by_owner(login)
  end

  def new
    login = login_from_params
    @user = User.find_or_initialize_by_login(login)

    @user.new_record? and return redirect_to action: "create"

    @repos = Repo.find_all_by_owner(login)

    @github_repos = github_list_repos_for_user(login)

  end

  def create
    login = login_from_params
    @user = User.find_or_initialize_by_login(login)
    
    if @user.new_record?
      @user.create_and_update_from_github
      flash[:notice] = "User #{ @user.login } successfully added."
      redirect_to action: "new"

    else
      flash[:notice] = "User #{ @user.login } already known."
      redirect_to action: "show"
      
    end


      # github.users.get(login)
      # github.repos.get(owner, name)
      # github.repos.list(user: login)

  end

protected
  
  def login_from_params(login = params[:owner])
    login
  end

  def github_list_repos_for_user(login)
    github = Github.new
    github.repos.list(user: login)
  end

end
