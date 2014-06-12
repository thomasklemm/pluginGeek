class LinksController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize Link, :index?
    load_links
  end

  def new
    @link = Link.find_or_initialize_by url: params[:url]

    # Redirect to edit path if link is already known
    redirect_to edit_link_path(@link) if @link.persisted?

    # Set link title from params
    @link.title = params[:title]
    @link.submitter ||= current_user
    authorize @link
  end

  def create
    build_link

    if @link.save
      redirect_to edit_link_path(@link), notice: 'Link has been created.'
    else
      render :new
    end
  end

  def edit
    load_link
  end

  def update
    load_link

    if @link.update(link_params)
      redirect_to edit_link_path(@link), notice: 'Link has been updated.'
    else
      render :edit
    end
  end

  def destroy
    load_link

    @link.destroy
    redirect_to root_url, notice: 'Link has been destroyed.'
  end

  private

  def load_links
    @links = Link.order(created_at: :desc)
  end

  def load_link
    @link = Link.find params[:id]
    authorize @link
  end

  def build_link
    @link = Link.new(link_params)
    @link.submitter ||= current_user
    authorize @link
  end

  def link_params
    link_params = params.fetch :link, {}
    link_params.permit policy(Link).permitted_attributes
  end
end
