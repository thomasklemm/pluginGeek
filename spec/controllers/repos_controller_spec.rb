require 'spec_helper'

shared_context "repo" do
  let!(:category) { Fabricate(:category) }
  let!(:repo)     { Fabricate(:repo, categories: [category]) }

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
      before { get :show, owner: repo.owner, name: 'any_name' }

      it { should redirect_to(root_path) }
      it { should set_the_flash.to("Record could not be found.") }
    end
  end

  context "guest" do
    include_examples "repos#show for guest, user and staff"
  end
end
