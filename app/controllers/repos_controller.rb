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
    user = params[:github_user]
    
    if user 
      @github_user = github_user(user)
      @github_user_repos = github_user_repos(user)
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

  def github_user(user = params[:github_user])
    github_api_url = "https://api.github.com/users/" + user
    http = Curl::Easy.perform(github_api_url)
    github_user = JSON.parse(http.body_str)
  end

  def github_user_repos(user = params[:github_user])
    github_api_url = "https://api.github.com/users/" + user + "/repos"
    http = Curl::Easy.perform(github_api_url)
    github_user_repos = JSON.parse(http.body_str)
  end

end
