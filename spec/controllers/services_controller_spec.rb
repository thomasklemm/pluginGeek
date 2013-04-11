require 'spec_helper'

shared_context "service" do
  let(:service) { Fabricate(:service) }

  let(:valid_service_attributes) { Fabricate.attributes_for(:service) }
  let(:invalid_service_attributes) { Fabricate.attributes_for(:service, name: nil) }

  let(:staff)   { Fabricate(:user, staff: true) }
  before { sign_in staff }
end

describe ServicesController do
  it_should_behave_like "an authenticated controller", {
    index:  [:get],
    show:   [:get, id: 1],
    new:    [:get],
    create: [:post],
    edit:   [:get, id: 1],
    update: [:put, id: 1],
    destroy: [:delete, id: 1]
  }
end

describe ServicesController, "GET #index" do
  include_context "service"
  before do
    service
    get :index
  end

  it { should respond_with(:success) }
  it { should render_template(:index) }
  it { should_not set_the_flash }
end

describe ServicesController, "GET #show" do
  include_context "service"
  before { get :show, id: service }
  it { should respond_with(:success) }
  it { should render_template(:show) }
  it { should_not set_the_flash }
end

describe ServicesController, "GET #new" do
  include_context "service"
  before { get :new }
  it { should respond_with(:success) }
  it { should render_template(:new) }
  it { should_not set_the_flash }
end

describe ServicesController, "GET #edit" do
  include_context "service"
  before { get :edit, id: service }
  it { should respond_with(:success) }
  it { should render_template(:edit) }
  it { should_not set_the_flash }
end

describe ServicesController, "POST #create" do
  include_context "service"

  context "valid service attributes" do
    before { post :create, service: valid_service_attributes }
    it { should redirect_to(service_path(assigns(:service)))}
    it { should set_the_flash.to('Service has been created.') }
  end

  context "invalid service attributes" do
    before { post :create, service: invalid_service_attributes }
    it { should render_template(:new) }
    it { should_not set_the_flash }
  end
end


describe ServicesController, "PUT #update" do
  include_context "service"

  context "valid service attributes" do
    before { put :update, id: service, service: valid_service_attributes }
    it { should redirect_to(service_path(assigns(:service)))}
    it { should set_the_flash.to('Service has been updated.') }
  end

  context "invalid service attributes" do
    before { put :update, id: service, service: invalid_service_attributes }
    it { should render_template(:edit) }
    it { should_not set_the_flash }
  end
end

describe ServicesController, "DELETE #destroy" do
  include_context "service"

  before { delete :destroy, id: service }
  it { should redirect_to(services_path) }
  it { should set_the_flash.to('Service has been destroyed.') }
end
