class CategoriesController < ApplicationController

  before_filter :require_login, only: :update

  # GET root without subdomain
  def choose_language
    # remove any subdomains
    return redirect_to root_url(subdomain: false) if request.subdomain.present?

    render 'choose_language', layout: 'choose_language_layout'
  end

  # GET root with subdomain ruby, js or design
  #   and GET /categories
  def index
    # remove any unknown subdomains
    return redirect_to root_url(subdomain: false) unless request.subdomain.match(/\b(ruby|js|design)\b/)

    @categories = Category.language(request.subdomain).has_repos.order_ks
  end

  # GET /categories/:id
  def show
    @category = Category.find_by_slug(params[:id])

    @repos = Repo.tagged_with(@category.name).order_ks
  end

  # PUT /categories/:id
  def update
    @category = Category.find_by_slug(params[:id])

    if @category.update_attributes(params[:category])
      flash[:notice] = 'Category description updated.'
      redirect_to action: 'show'
    else
      flash[:alert] = 'Category description could not be updated.'
      redirect_to action: 'show'
    end
  end



end
