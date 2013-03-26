require 'spec_helper'

shared_context "categories" do
  let!(:language) { Fabricate(:language) }
  let!(:category) { Fabricate(:category, languages: [language]) }

  let(:user)  { Fabricate(:user) }
  let(:staff) { Fabricate(:user, staff: true) }
end

describe CategoriesController, "GET #index" do
  include_context "categories"

  shared_examples "categories#index for guest, user and staff" do
    before { get :index, language: language }

    it { should respond_with(:success) }
    it { should render_template(:index) }
    it { should_not set_the_flash }

    it "assigns and decorates @language" do
      expect(assigns(:language)).to be_present
      expect(assigns(:language)).to be_decorated
    end

    it "assigns and decorates @categories" do
      expect(assigns(:categories)).to be_present
      expect(assigns(:categories).first).to be_decorated
    end
  end

  context "guest" do
    include_examples "categories#index for guest, user and staff"
  end

  context "user" do
    before { sign_in user }
    include_examples "categories#index for guest, user and staff"
  end

  context "staff" do
    before { sign_in staff }
    include_examples "categories#index for guest, user and staff"
  end
end

shared_context "category" do
  let!(:category) { Fabricate(:category) }
  let!(:repo)     { Fabricate(:repo, categories: [category]) }

  let(:user)  { Fabricate(:user) }
  let(:staff) { Fabricate(:user, staff: true) }
end

describe CategoriesController, "GET #show" do
  include_context "category"

  shared_examples "categories#show for guest, user and staff" do
    before { get :show, id: category }

    it { should respond_with(:success) }
    it { should render_template(:show) }
    it { should_not set_the_flash }

    it "assigns and decorates @category" do
      expect(assigns(:category)).to be_present
      expect(assigns(:category)).to be_decorated
    end

    it "assigns and decorates @repos" do
      expect(assigns(:repos)).to be_present
      expect(assigns(:repos).first).to be_decorated
    end

    it "redirects to the updated path if called with outdated path"
  end

  context "guest" do
    include_examples "categories#show for guest, user and staff"
  end

  context "user" do
    before { sign_in user }
    include_examples "categories#show for guest, user and staff"
  end

  context "staff" do
    before { sign_in staff }
    include_examples "categories#show for guest, user and staff"
  end
end

describe CategoriesController, "GET #edit", :focus do
  include_context "category"

  shared_examples "categories#edit for user and staff" do
    before { get :edit, id: category }

    it { should respond_with(:success) }
    it { should render_template(:edit) }
    it { should_not set_the_flash }
  end

  context "guest" do
    before { get :edit, id: 1 }
    it_should_behave_like "an authenticated controller action"
  end

  context "user" do
    before { sign_in user }
    include_examples "categories#edit for user and staff"
  end

  context "staff" do
    before { sign_in staff }
    include_examples "categories#edit for user and staff"
  end
end

