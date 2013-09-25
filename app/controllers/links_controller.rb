class LinksController < ApplicationController
  before_action :authenticate_user!
  before_action :load_link, only: [:edit, :update, :destroy]

  def index
    @links = Link.order(published_at: :desc)
  end

  def new
    @link = Link.find_or_initialize_by(url: params[:url])

    # Redirect to edit path if link is already known
    @link.persisted? and redirect_to edit_link_path(@link)

    # Set title and default published_at
    @link.title, @link.published_at = params[:title], Date.current
    authorize @link
  end

  def create
    @link = Link.new(link_params)
    @link.submitter = current_user
    authorize @link

    if @link.save
      redirect_to edit_link_path(@link), notice: 'Link has been created.'
    else
      render :new
    end
  end

  def edit
    authorize @link
  end

  def update
    authorize @link

    if @link.update(link_params)
      redirect_to edit_link_path(@link), notice: 'Link has been updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @link

    @link.destroy
    redirect_to root_url, notice: 'Link has been destroyed.'
  end

  private

  def load_link
    @link = Link.find(params[:id])
  end

  def link_params
    params.require(:link).permit(:title, :url, :published_at, { repo_ids: [] }, { category_ids: [] })
  end
end
