class ReposController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :load_repo, except: :create
  before_action :build_repo, only: :create

  def show
    render :new if @repo.new_record?
  end

  def create
    if RepoService.new(@repo).fetch_and_create_or_update
      redirect_to @repo, notice: 'Repo has been listed.'
    else
      flash.alert = 'Repo has not been listed. Please retry later,
        as the Github API might be down.'
      redirect_to root_path
    end
  end

  def edit
  end

  def update
    if @repo.update(repo_params)
      @repo.retrieve_from_github if @repo.owner_and_name_changed?
      redirect_to repo_path(@repo), notice: 'Repo has been updated.'
    else
      render :edit
    end
  end

  def destroy
    @repo.destroy
    redirect_to root_path, notice: 'Repo has been destroyed.'
  end

  private

  def load_repo
    @repo = Repo.find_by_owner_and_name!(owner_and_name)
    authorize @repo
  rescue ActiveRecord::RecordNotFound
    if request.fullpath != repo_path(owner_and_name)
      redirect_to repo_path(owner_and_name)
    end
    build_repo
  end

  def build_repo
    @repo = Repo.new(owner_and_name: owner_and_name)
    authorize @repo, :create?
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
