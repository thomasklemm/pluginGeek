class CategoriesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    load_categories
  end

  def show
    load_category
  end

  def new
    @category = Category.new
    authorize @category
  end

  def create
    @category = Category.new(category_params)
    authorize @category

    if @category.save
      redirect_to @category, notice: 'Category has been created.'
    else
      render :new
    end
  end

  def edit
    load_category
  end

  def update
    load_category

    if @category.update(category_params)
      redirect_to @category, notice: 'Category has been updated.'
    else
      render :edit
    end
  end

  def destroy
    load_category
    @category.destroy
    redirect_to root_path, notice: 'Category has been destroyed.'
  end

  private

  def load_categories
    @categories ||= categories_scope
  end

  def categories_scope
    scope = Category.for_platform(platform_slug)
    scope = scope.includes(:platforms, :repos)
    scope = scope.order(published: :desc, score: :desc)
    scope = scope.page(params[:page])
    scope
  end

  def load_category
    @category ||= Category.find(params[:id]).decorate
    authorize @category
  end

  # Transforms aliases into known platform slugs
  def platform_slug
    slug = params[:platform_slug].to_s
    slug = slug.strip.downcase

    slug = nil if slug.blank? || slug == 'all'
    slug = 'javascript' if slug == 'js'

    slug
  end

  def category_params
    params.
      require(:category).
      permit(policy(@category).permitted_attributes)
  end
end
