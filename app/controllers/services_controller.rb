class ServicesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_staff_member!
  before_action :load_service, except: [:index, :new, :create]

  def index
    @services = Service.order(created_at: :desc)
  end

  def show
  end

  def new
    @service = Service.new
  end

  def create
    @service = Service.new(service_params)

    if @service.save
      redirect_to @service, notice: 'Service has been created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @service.update(service_params)
      redirect_to @service, notice: 'Service has been updated.'
    else
      render :edit
    end
  end

  def destroy
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
