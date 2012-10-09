class ReposController < ApplicationController

  # Before Filters
  before_filter :require_login, only: [:edit, :update]
  before_filter :find_repo, only: [:show, :create, :edit, :update]

  # GET /repos
  def index
    @repos = Repo.find_all_by_language(language).includes(:children)

    # HTTP Caching
    if !Rails.env.development? && !Rails.env.test?
      expires_in 10.minutes
      fresh_when last_modified: @repos.maximum(:updated_at), public: true
    end
  end

  # GET /repos/:owner/:name(/*leftover)
  def show
    # Redirect to create action if @repo is a new record
    @repo.new_record? and render 'add_repo'

    # Always redirect to repo base url without leftover
    #   (might be attached when clicking bookmarklet on github repo's wiki page etc.)
    params[:leftover] and return redirect_to @repo
  end

  # POST /repos/:owner/:name
  def create
    if RepoUpdater.new.perform(@repo.full_name)

      # Reload for correct redirection path
      @repo = Repo.find_by_full_name(@repo.full_name)

      flash[:notice] ||= "Added repo '#{ @repo.full_name }'. Please add a tag so it can be found."
      redirect_to @repo
    else
      flash[:alert] = "Failed to add repo '#{ @repo.full_name }'."
      redirect_to root_path
    end
  end

  # GET /repos/:owner/:name/edit
  def edit
  end

  # PUT /repos/:owner/:name
  def update
    # REVIEW: Working?
    params[:repo][:category_list] &&= params[:repo][:category_list].split(',').join(', ')

    if @repo.update_attributes(params[:repo])
      flash[:notice] = 'Repo saved.'
      redirect_to action: :show
    else
      flash.now.alert = 'Failed to save repo!'
      render action: :edit
    end
  end

protected

  ##
  # Before Filters
  def find_repo
    @repo = Repo.where(full_name: full_name_from_params).includes([:children, :parents, {:parents => :children}, {:children => :children}, {:categories => {:repos => :children}}]).first_or_initialize
  end

  ##
  # Helper Methods
  def full_name_from_params(owner = params[:owner], name = params[:name])
    "#{owner}/#{name}"
  end

end
