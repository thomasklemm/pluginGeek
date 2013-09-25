class ReposController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :load_and_authorize_repo, except: [:new, :create]

  # GET /repos/:owner/:name
  def show
  end

  # GET /repos/new?owner=thomasklemm&name=Plugingeek
  def new
    @repo = Repo.new(full_name: full_name)
    authorize @repo
  end

  def create
    @repo = Repo.new(full_name: full_name)
    authorize @repo

    if @repo.retrieve_from_github
      redirect_to repo_path(@repo), notice: 'Repo has been added.'
    else
      flash.alert = 'Repo could not be found on Github.
        This might be a temporary error, please try again later.'
      redirect_to root_path
    end
  end

  def edit
  end

  def update
    if @repo.update(repo_params)
      @repo.retrieve_from_github if @repo.full_name_changed?
      redirect_to repo_path(@repo), notice: 'Repo has been updated.'
    else
      render :edit
    end
  end

  def destroy
    @repo.destroy
    redirect_to root_path, notice: 'Repo has been destroyed.'
  end

  def refresh
    @repo.retrieve_from_github and @repo.touch
    redirect_to repo_path(@repo), notice: 'Repo has been refreshed.'
  end

  private

  def load_repo
    @repo ||= Repo.find_by!(full_name: full_name)
    authorize @repo
  rescue ActiveRecord::RecordNotFound
    redirect_to new_repo_path(full_name: full_name)
  end

  # GET /repos/:owner/:name
  def full_name
    owner_and_name_from_params || full_name_from_params
  end

  def full_name_from_params
    params[:full_name] || (params[:repo] && params[:repo][:full_name])
  end

  def owner_and_name_from_params
    owner = params[:owner] || (params[:repo] && params[:repo][:owner])
    name  = params[:name]  || (params[:repo] && params[:repo][:name])
    (owner && name) ? "#{ owner }/#{ name }" : nil
  end

  def repo_params
    params.require(:repo).permit(policy(@repo).permitted_attributes)
  end
end
