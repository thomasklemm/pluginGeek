class CategoriesController < ApplicationController

  before_filter :require_login, only: :update

  # GET /categories
  def index
    # if the request has a subdomain that is unknown
    #   we should remove it;
    #   only valid or empty subdomains should make it past this method
    if request.subdomain.present?
      request.subdomain.match(/\b(ruby|js|design)\b/) or return redirect_to root_url(subdomain: false)
    end

    # Find categories (all or limited to language specified in subdomain)
    @categories = Category.tagged_with_language(request.subdomain).has_repos.order_knight_score
  end

  # GET /categories/:id
  def show
    # friendly_id's slug serves as params[:id]
    @category = Category.find(params[:id])

    # If an old id or a numeric id was used to find the record, then
    #   the request path will not match the category_path, and we should do
    #   a 301 redirect that uses the current friendly id.
    #   (Source: friendly_id docs)
    if request.path != category_path(@category)
      return redirect_to @category, status: :moved_permanently
    end

    @repos = Repo.tagged_with(@category.name, on: :categories).order_knight_score
  end

  # PUT /categories/:id
  def update
    @category = Category.find(params[:id])

    if @category.update_attributes(params[:category])
      flash[:notice] = 'Category description updated.'
      redirect_to action: 'show'
    else
      flash[:alert] = 'Category description could not be updated.'
      redirect_to action: 'show'
    end
  end

end
