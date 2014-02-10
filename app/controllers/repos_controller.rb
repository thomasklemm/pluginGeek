class ReposController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :load_or_build_repo, only: [:show, :create]
  before_action :load_repo, except: [:show, :create]

  def show
    if request.fullpath != repo_path(owner_and_name)
      return redirect_to repo_path(owner_and_name)
    end

    render :new if @repo.new_record?
  end

  def create
    if RepoService.new(@repo).fetch_and_create_or_update
      redirect_to @repo, notice: "#{@repo.owner_and_name} is now listed on Plugingeek."
    else
      flash.alert = "#{@repo.owner_and_name} could not be found on Github."
      redirect_to repo_path(@repo.owner_and_name)
    end
  end

  def edit
  end

  def update
    if @repo.update(repo_params)
      @repo.retrieve_from_github if @repo.owner_and_name_changed?
      redirect_to repo_path(@repo), notice: "#{@repo.owner_and_name} has been updated."
    else
      render :edit
    end
  end

  def destroy
    @repo.destroy
    redirect_to root_path, notice: "#{@repo.owner_and_name} has been removed from Plugingeek."
  end

  private

  def load_or_build_repo
    load_repo
  rescue ActiveRecord::RecordNotFound
    build_repo
  end

  def load_repo
    @repo = Repo.find_by_owner_and_name!(owner_and_name)
    authorize @repo
  end

  def build_repo
    @repo = Repo.new(owner_and_name: owner_and_name)
    authorize @repo, :new?
  end

  def owner_and_name
    params[:id] or
    params[:owner_and_name] or
    (params[:owner] && params[:name]) &&
      "#{params[:owner]}/#{params[:name]}" or
    params[:repo] && params[:repo][:owner_and_name] or
    (params[:repo] && params[:repo][:owner] && params[:repo][:name]) &&
      "#{params[:repo][:owner]}/#{params[:repo][:name]}"
  end

  def repo_params
    params.
      require(:repo).
      permit(policy(@repo).permitted_attributes)
  end
end
