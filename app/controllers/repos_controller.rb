class ReposController < ApplicationController
  before_action :authenticate_user!, except: :show

  def show
    load_repo
    redirect_to_updated_repo_path
  end

  def new
    build_repo
    @repo.owner_and_name = owner_and_name # pre-fill field from params

    redirect_to_existing_repo
  end

  def create
    build_repo

    if @repo.valid?
      if fetch_repo_from_github
        redirect_to @repo, notice: "#{owner_and_name} is now listed on Plugingeek."
      else
        flash.now.alert = "#{owner_and_name} could not be found on Github."
        render :new
      end
    else
      render :new
    end
  end

  def edit
    load_repo
  end

  def update
    load_repo

    if @repo.update(repo_params)
      fetch_repo_from_github if @repo.owner_and_name_changed?
      redirect_to repo_path(@repo), notice: "#{owner_and_name} has been updated."
    else
      render :edit
    end
  end

  def destroy
    load_repo
    @repo.destroy
    redirect_to root_path, notice: "#{owner_and_name} has been removed from Plugingeek."
  end

  private

  def load_repo
    @repo = Repo.find_by_owner_and_name!(owner_and_name)
    authorize @repo
  end

  def build_repo
    @repo = Repo.new(repo_params)
    authorize @repo
  end

  def fetch_repo_from_github
    RepoService.new(@repo).fetch_and_create_or_update
  end

  def owner_and_name
    @repo.try(:owner_and_name) or
    params[:id] or
    params[:owner_and_name] or
    params[:repo].andand[:owner_and_name]
  end

  def redirect_to_updated_repo_path
    if request.fullpath != repo_path(@repo)
      redirect_to @repo
    end
  end

  def redirect_to_existing_repo
    repo = Repo.find_by_owner_and_name(owner_and_name)
    redirect_to repo if repo
  end

  def repo_params
    repo_params = params.fetch :repo, {}
    repo_params.permit policy(@repo || Repo).permitted_attributes
  end
end
