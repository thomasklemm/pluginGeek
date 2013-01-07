class CategoriesController < ApplicationController
  # Filters
  before_filter :find_language, only: :index

  before_filter :find_category_and_repos, except: :index
  before_filter :authenticate_user!, only: [:edit, :update]

  # GET '/:language'
  def index
    @categories = @language.categories
  end

  # GET /categories/:id
  def show
    redirect_on_request_to_outdated_path
  end

  # GET /categories/:id/edit
  def edit
  end

  # PUT /categories/:id
  def update
    # escape description attribute
    params[:category][:description] &&= view_context.strip_tags(params[:category][:description])

    if @category.update_attributes(params[:category])
      redirect_to @category, notice: 'Thanks! Your update is saved.'
    else
      flash.now.alert = 'AARRGH! Please let me know by mail how you got this error! Thanks in advance.'
      render action: :edit
    end
  end

protected

  def find_language
    @language = Language.find(params[:language])
  end

  def find_category_and_repos
    # params[:id] brings friendly_id's slug
    @category = Category.find(params[:id])

    @repos = @category.repos.includes(:children)
  end

  # If an old id or a numeric id was used to find the record, then
  # the request path will not match the category_path, and we should do
  # a 301 redirect that uses the current friendly id. (Source: friendly_id docs)
  def redirect_on_request_to_outdated_path
    if request.path != category_path(@category)
      return redirect_to @category, status: :moved_permanently
    end
  end

end
