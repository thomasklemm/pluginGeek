class CategoriesController < ApplicationController
  before_filter :authenticate_user!, only: [:edit, :update, :destroy]
  before_filter :load_category_and_repos, only: [:show, :edit, :update, :destroy]
  after_filter :verify_authorized, only: [:edit, :update, :destroy]

  # GET '/:language'
  def index
    @language = Language.find(params[:language]).decorate
    @categories = @language.categories
  end

  def show
    redirect_on_request_to_outdated_path
  end

  def edit
    authorize @category
  end

  def update
    authorize @category

    if @category.update_attributes(category_params)
      redirect_to @category, notice: 'Category has been updated.'
    else
      flash.now.alert = 'An error has happened while updating the category. \
                         Please reach out to me by email if this error persists.'
      render action: :edit
    end
  end

  def destroy
    authorize @category

    # TODO: Ensure repos are empty

    @category.destroy
    redirect_to root_path, notice: 'Category has been destroyed.'
  end

  private

  # If an old id or a numeric id was used to find the record, then
  # the request path will not match the category_path, and we should do
  # a 301 redirect that uses the current friendly id. (Source: friendly_id docs)
  def redirect_on_request_to_outdated_path
    if request.path != category_path(@category)
      return redirect_to @category, status: :moved_permanently
    end
  end

  def load_category_and_repos
    @category = Category.find(params[:id]).decorate
    @repos = @category.repos
  end

  def category_params
    current_user.staff? ? staff_category_params : user_category_params
  end

  def staff_category_params
    params.require(:category).permit(:full_name, :description, :draft)
  end

  def user_category_params
    params.require(:category).permit(:description)
  end
end
