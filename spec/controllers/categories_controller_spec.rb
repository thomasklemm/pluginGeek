require 'spec_helper'

shared_context "categories" do
  let!(:language) { Fabricate(:language) }
  let!(:category) { Fabricate(:category) }

  before { category.languages << language }

  let(:user)  { Fabricate(:user) }
  let(:staff) { Fabricate(:user, staff: true) }
end

shared_context "category" do
  let!(:category) { Fabricate(:category) }
  let!(:repo)     { Fabricate(:repo) }

  before { repo.categories << category }

  let(:user)  { Fabricate(:user) }
  let(:staff) { Fabricate(:user, staff: true) }

  let(:valid_category_attributes) { { description: 'new_description' } }
  let(:long_string) { "0" * 361 }
  let(:invalid_category_attributes) { { description: long_string } }
end

describe CategoriesController do
  context "guest" do
    it_should_behave_like "an authenticated controller", {
      edit:   [:get, id: 1],
      update: [:put, id: 1],
      destroy: [:delete, id: 1]
    }
  end

  describe "#category_params" do
    let(:user)  { Fabricate(:user) }
    let(:staff) { Fabricate(:user, staff: true) }

    before do
     subject.params[:category] = {
        full_name: 'new_category_name',
        description: 'new_category_description',
        draft: false,
        featured: true,
        related_category_ids: [1, 2, 3]
      }
    end

    context "staff" do
      before  { sign_in staff }
      let(:params) { controller.send(:category_params) }

      it "permits description" do
        expect(params[:description]).to be_present
      end

      it "permits full_name" do
        expect(params[:full_name]).to be_present
      end

      it "permits draft" do
        expect(params[:draft]).to_not be_nil # boolean FALSE is expected
      end

      it "permits featured" do
        expect(params[:featured]).to be_present
      end

      it "permits related_category_ids" do
        expect(params[:related_category_ids]).to be_present
      end
    end

    context "user" do
      before  { sign_in user }
      let(:params) { controller.send(:category_params) }

      it "permits description" do
        expect(params[:description]).to be_present
      end

      it "doesn't permit full_name" do
        expect(params[:full_name]).to be_nil
      end

      it "doesn't permit draft" do
        expect(params[:draft]).to be_nil
      end

      it "doesn't permit featured" do
        expect(params[:featured]).to be_nil
      end

      it "doesn't permit related_category_ids" do
        expect(params[:related_category_ids]).to be_nil
      end
    end
  end
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

describe CategoriesController, "GET #show" do
  include_context "category"

  shared_examples "categories#show for guest, user and staff" do
    context "category found" do
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
    end

    context "category not found" do
      before { get :show, id: "unknown_category" }

      it { should redirect_to(root_path) }
      it { should set_the_flash.to("Category 'unknown_category' could not be found.") }
    end
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

describe CategoriesController, "GET #edit" do
  include_context "category"

  shared_examples "categories#edit for user and staff" do
    before { get :edit, id: category }

    it { should respond_with(:success) }
    it { should render_template(:edit) }
    it { should_not set_the_flash }
    it { should authorize_resource }
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

describe CategoriesController, "PUT #update" do
  include_context "category"

  shared_examples "categories#update for user and staff" do
    context "valid category attributes" do
      before { put :update, id: category, category: valid_category_attributes }

      it { should authorize_resource }
      it { should set_the_flash.to('Category has been updated.') }

      it "redirects to the category" do
        expect(response).to redirect_to(category)
      end

      it "saves the changes in the database" do
        assigns(:category).reload
        expect(assigns(:category).description).to eq(valid_category_attributes[:description])
      end
    end

    context "invalid category attributes" do
      before { put :update, id: category, category: invalid_category_attributes }

      it { should render_template(:edit) }
      it { should authorize_resource }
      it { should_not set_the_flash }

      it "doesn't save the changes in the database" do
        assigns(:category).reload
        expect(assigns(:category).description).to_not eq(invalid_category_attributes[:description])
      end
    end
  end

  context "user" do
    before { sign_in user }
    include_examples "categories#update for user and staff"
  end

  context "staff" do
    before { sign_in staff }
    include_examples "categories#update for user and staff"
  end
end

describe CategoriesController, "DELETE #destroy" do
  include_context "category"

  context "staff" do
    before do
      sign_in staff
      delete :destroy, id: category
    end

    it { should authorize_resource }
    it { should redirect_to(root_path) }
    it { should set_the_flash.to('Category has been destroyed.') }

    it "destroys the category" do
      expect(assigns(:category)).to be_destroyed
    end
  end

  context "user" do
    before do
      sign_in user
      request.env["HTTP_REFERER"] = "where_i_came_from" unless request.nil? or request.env.nil?
      delete :destroy, id: category
    end

    it { should authorize_resource }
    it { should redirect_to('where_i_came_from') }
    it { should set_the_flash.to(/not authorized/) }

    it "doesn't destroy the category" do
      expect(assigns(:category)).to_not be_destroyed
    end
  end
end
