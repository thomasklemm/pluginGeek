class ReposController < ApplicationController

  # Before Filters
  before_filter :require_login, only: [:edit, :update]
  before_filter :find_repo, except: :index
  before_filter :find_alternatives, except: :index

  # GET /repos
  def index
    @repos = Repo.ordered_find_all_by_language(language)
    # Don't do such scalablity shit before it's nescessary.
    # Rather make happen that it becomes nescessary!
    # if !Rails.env.development? && !Rails.env.test?
    #   expires_in 10.minutes
    #   fresh_when last_modified: @repos.maximum(:updated_at), public: true
    # end
  end

  # GET /repos/:owner/:name(/*leftover)
  def show
    # Redirect to create action if @repo is a new record
    @repo.new_record? and render 'add_repo'

    # Always redirect to repo base url without leftover
    #   (can be attached when coming from github via bookmarklet)
    params[:leftover] and return redirect_to @repo
  end

  # POST /repos/:owner/:name/create
  def create
    # Set different flash message if repo is already known
    @repo.new_record? or flash[:notice] = "Repo '#{ @repo.full_name }' already known."

    if repo_updater.perform(@repo.full_name)
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
    render action: :show
  end

  # PUT /repos/:owner/:name
  def update
    params[:repo][:category_list] &&= params[:repo][:category_list].split(',').join(', ')
    if @repo.update_attributes(params[:repo])

      # REVIEW: THIS NEEDS TO BE MORE EFFICIENT

      # Update repo, parents and categories
      @repo.after_repo_update

      # Insert new categories
      CategoryUpdater.update_categories_serial

      flash[:notice] = 'Tags successfully saved.'
      redirect_to action: 'show'
    else
      flash.now.alert = 'Failed to save tags.'
      render action: 'show'
    end
  end

protected

  ###
  #   Before Filters
  ###

  # Find or initialize repo
  def find_repo
    @repo = Repo.find_or_initialize_by_full_name(full_name_from_params)
  end

  # Find alternatives
  def find_alternatives
    # Find alternative repos
    @alternatives = @repo.category_list.present? ? @repo.find_related_categories.order_by_knight_score : []
  end

  ###
  #   Helper Methods
  ###

  def full_name_from_params(owner = params[:owner], name = params[:name])
    "#{owner}/#{name}"
  end

end
