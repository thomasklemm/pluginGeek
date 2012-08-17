class CategoriesController < ApplicationController

  # Before Filters
  before_filter :require_login, only: [:edit, :update]
  before_filter :find_category_and_repos, except: :index

  # GET /categories
  def index
    # Cache in Rack-Cache for 30 seconds
    response.headers['Cache-Control'] = 'public, max-age=90'
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
    # Prepare Attributes
    #   Short Description: Render Markdown & Strip Tags & Squish
    #     To remove links and emphasis if someone accidentally inputs markdown or mischiefiously inputs <script> tags
    params[:category][:short_description] &&= view_context.strip_tags(markdown.render(params[:category][:short_description])).squish

    # Update attributes
    if @category.update_attributes(params[:category])
      # Update success
      redirect_to @category, notice: 'Category updated. Thanks a lot!'
    else
      # Update failed
      flash.now.alert = "Category update failed. Please let me know how you got this error."
      render action: :edit
    end
  end

protected

  # Find category and repos
  def find_category_and_repos
    # friendly_id's slug serves as params[:id]
    @category = Category.find(params[:id])
    # Find all repos by category
    @repos = Repo.ordered_find_all_by_category(@category.name)
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
