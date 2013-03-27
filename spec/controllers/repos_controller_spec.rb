require 'spec_helper'

shared_context "repo" do
  let!(:repo)     { Fabricate(:repo) }

  let(:user)  { Fabricate(:user) }
  let(:staff) { Fabricate(:user, staff: true) }
end

describe ReposController do
  context "guest" do
    it_should_behave_like "an authenticated controller", {
      new:     [:get, owner: 'owner', name: 'name'],
      create:  [:post, owner: 'owner', name: 'name'],
      edit:    [:get, owner: 'owner', name: 'name'],
      update:  [:put, owner: 'owner', name: 'name'],
      destroy: [:delete, owner: 'owner', name: 'name'],
    }
  end

  describe "#repo_params" do
    let(:user)  { Fabricate(:user) }
    let(:staff) { Fabricate(:user, staff: true) }

    before do
     subject.params[:repo] = {
        full_name: 'new_owner/new_name',
        description: 'new_description',
        category_list: 'new_first_category, new_second_category',
        staff_pick: true,
        parent_ids: [1, 2, 3]
      }
    end

    context "staff" do
      before { sign_in staff }
      let(:params) { controller.send(:repo_params) }

      it "permits full_name" do
        expect(params[:full_name]).to be_present
      end

      it "permits description" do
        expect(params[:description]).to be_present
      end

      it "permits category_list" do
        expect(params[:category_list]).to be_present
      end

      it "permits staff_pick" do
        expect(params[:staff_pick]).to be_present
      end

      it "permits parent_ids" do
        expect(params[:parent_ids]).to be_present
      end
    end

    context "user" do
      before { sign_in user }
      let(:params) { controller.send(:repo_params) }

      it "doesn't permit full_name" do
        expect(params[:full_name]).to be_nil
      end

      it "permits description" do
        expect(params[:description]).to be_present
      end

      it "permits category_list" do
        expect(params[:category_list]).to be_present
      end

      it "doesn't permit staff_pick" do
        expect(params[:staff_pick]).to be_nil
      end

      it "permits parent_ids" do
        expect(params[:parent_ids]).to be_present
      end
    end
  end
end

describe ReposController, "GET #show" do
  include_context "repo"

  shared_examples "repos#show for guest, user and staff" do
    context "repo found" do
      before { get :show, owner: repo.owner, name: repo.name }

      it { should respond_with(:success) }
      it { should render_template(:show) }
      it { should_not set_the_flash }

      it "assigns and decorates @repo" do
        expect(assigns(:repo)).to be_present
        expect(assigns(:repo)).to be_decorated
      end
    end

    context "repo not found" do
      before { get :show, owner: 'any_owner', name: 'any_name' }

      it { should redirect_to(root_path) }
      it { should set_the_flash.to("Record could not be found.") }
    end
  end

  context "guest" do
    include_examples "repos#show for guest, user and staff"
  end

  context "user" do
    before { sign_in user }
    include_examples "repos#show for guest, user and staff"
  end

  context "staff" do
    before { sign_in staff }
    include_examples "repos#show for guest, user and staff"
  end
end

describe ReposController, "GET #new" do
  include_context "repo"

  shared_examples "repos#new for user and staff" do
    before { get :new, owner: 'owner', name: 'name' }

    it { should authorize_resource }
    it { should respond_with(:success) }
    it { should render_template(:new) }
    it { should_not set_the_flash }

    it "assigns a new repo to @repo" do
      expect(assigns(:repo)).to be_present
      expect(assigns(:repo)).to be_new_record
    end
  end

  context "user" do
    before { sign_in user }
    include_examples "repos#new for user and staff"
  end

  context "staff" do
    before { sign_in staff }
    include_examples "repos#new for user and staff"
  end
end

describe ReposController, "POST #create" do
  include_context "repo"

  shared_examples "repos#create for user and staff" do
    context "with valid repo full_name" do
      before { post :create, repo: { owner: 'rails', name: 'rails' } }

      it { should authorize_resource }
      it { should set_the_flash.to('Repo has been added.') }

      it "redirects to the repo" do
        expect(response).to redirect_to(repo_path(assigns(:repo)))
      end

      pending "retrieves the repo's details from Github"
    end

    context "with invalid repo full_name" do
      before { post :create, repo: { owner: 'none', name: 'none' }  }

      it { should authorize_resource }
      it { should redirect_to(root_path) }
      it { should set_the_flash.to(/Repo could not be found on Github/) }
    end
  end

  context "user" do
    before { sign_in user }
    include_examples "repos#create for user and staff"
  end

  context "staff" do
    before { sign_in staff }
    include_examples "repos#create for user and staff"
  end
end

describe ReposController, "GET #edit" do
  include_context "repo"

  shared_examples "repos#edit for user and staff" do
    before { get :edit, owner: repo.owner, name: repo.name }

    it { should authorize_resource }
    it { should respond_with(:success) }
    it { should render_template(:edit) }
    it { should_not set_the_flash }

    it "assigns @repo" do
      expect(assigns(:repo)).to be_present
    end
  end

  context "user" do
    before { sign_in user }
    include_examples "repos#edit for user and staff"
  end

  context "staff" do
    before { sign_in staff }
    include_examples "repos#edit for user and staff"
  end
end

describe ReposController, "PUT #update" do
  include_context "repo"

  shared_examples "repos#update for user and staff" do
    before do
      put :update, owner: repo.owner, name: repo.name, repo: { description: 'new_one' }
    end

    it { should authorize_resource }
    it { should set_the_flash.to('Repo has been updated.') }

    it "redirects to the repo" do
      expect(response).to redirect_to(assigns(:repo))
    end
  end

  context "user" do
    before { sign_in user }
    include_examples "repos#update for user and staff"
  end

  context "staff" do
    before { sign_in staff }
    include_examples "repos#update for user and staff"
  end
end

describe ReposController, "DELETE #destroy" do
  include_context "repo"

  context "staff" do
    before do
      sign_in staff
      delete :destroy, owner: repo.owner, name: repo.name
    end

    it { should authorize_resource }
    it { should redirect_to(root_path) }
    it { should set_the_flash.to('Repo has been destroyed.') }

    it "destroys the repo" do
      expect(assigns(:repo)).to be_destroyed
    end
  end

  context "user" do
    before do
      sign_in user
      request.env["HTTP_REFERER"] = "where_i_came_from" unless request.nil? or request.env.nil?
      delete :destroy, owner: repo.owner, name: repo.name
    end

    it { should authorize_resource }
    it { should redirect_to('where_i_came_from') }
    it { should set_the_flash.to(/not authorized/) }

    it "doesn't destroy the repo" do
      expect(assigns(:repo)).to_not be_destroyed
    end
  end
end
