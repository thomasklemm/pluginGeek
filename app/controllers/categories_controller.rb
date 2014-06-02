class CategoriesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    load_categories
  end

  def show
    load_category
    redirect_to_updated_category_path
  end

  def new
    build_category
  end

  def create
    build_category

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
    @categories ||= categories_scope.decorate
  end

  def load_category
    @category ||= Category.find(params[:id]).decorate
    authorize @category
  end

  def build_category
    @category = Category.new(category_params).decorate
    authorize @category
  end

  def categories_scope
    scope = current_platform.categories
    scope = scope.includes(:platforms, :repos)
    scope = scope.order(published: :desc, score: :desc)
    scope.page params[:page]
  end

  def category_params
    category_params = params.fetch :category, {}
    category_params.permit policy(Category).permitted_attributes
  end

  # Transforms aliases into known platform slugs
  def platform_slug
    slug = params[:platform_slug].to_s
    slug = slug.strip.downcase

    slug = nil if slug.blank? || slug == 'all'
    slug = 'javascript' if slug == 'js'

    slug
  end

  def redirect_to_updated_category_path
    if request.fullpath != category_path(@category)
      redirect_to @category
    end
  end
end
