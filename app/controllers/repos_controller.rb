class ReposController < ApplicationController
  def index
    @repos = Repo.all
  end

  def show
    @repo = Repo.find_or_initialize_by_full_name(full_name_from_params)

    # Always redirect to base
    #   Be sure to return to finish request
    params[:leftover] and return redirect_to @repo

    # Redirect to create action if @repo is a new record
    @repo.new_record? and return redirect_to action: "create"
  end

  # Create ONE Repo
  def create
    @repo = Repo.find_or_initialize_by_full_name(full_name_from_params)

    @repo.new_record? or flash[:notice] = "Repo '#{@repo.full_name}' already known."
    
    if @repo.first_update_from_github
      flash[:notice] ||= "Repo '#{@repo.full_name}' successfully added."
      redirect_to @repo
    else
      flash[:alert] = "Repo '#{@repo.full_name}' could NOT be added."
      redirect_to root_path
    end
  end

  def new
    github_login = params[:github_login]
    
    if github_login
      @github_login = github_login
      @github_user = github_user(github_login)
      @github_user_repos = github_user_repos(github_login)
    end

  end

  def create_many
    repos = params[:repos]

    repos.each do |_, full_name|
      Repo.new(full_name: full_name).first_update_from_github
    end

    flash[:notice] = "Repos successfully added."
    redirect_to :root

  end

protected

  def full_name_from_params(owner = params[:owner], name = params[:name])
    "#{owner}/#{name}"
  end

  def github_user(login)
    github_users_api_request(login, :user)
  end

  def github_user_repos(login)
    github_users_api_request(login, :user_repos)
  end

  def github_users_api_request(login, scope)
    github_api_url = "https://api.github.com/users/" + login
    github_api_url += "/repos" if scope == :user_repos
    http = Curl::Easy.perform(github_api_url)
    res = JSON.parse(http.body_str)
    res = false if http.response_code == 404
    res
  end

end
