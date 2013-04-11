class ServicesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_service, only: [:show, :edit, :update, :destroy]
  after_filter :verify_authorized

  def index
    @services = Service.order('created_at DESC')
    authorize @services.first
  end

  def show
    authorize @service
  end

  def new
    @service = Service.new
    authorize @service
  end

  def create
    @service = Service.new(service_params)
    authorize @service

    if @service.save
      redirect_to service_path(@service), notice: 'Service has been created.'
    else
      render action: :new
    end
  end

  def edit
    authorize @service
  end

  def update
    authorize @service
    if @service.update_attributes(service_params)
      redirect_to service_path(@service), notice: 'Service has been updated.'
    else
      render action: :edit
    end
  end

  def destroy
    authorize @service
    @service.destroy
    redirect_to services_path, notice: 'Service has been destroyed.'
  end

  private

  def load_service
    @service = Service.find(params[:id])
  end

  def service_params
    params.require(:service).permit(:name, :display_url, :target_url, :description, { category_ids: [] })
  end
end
