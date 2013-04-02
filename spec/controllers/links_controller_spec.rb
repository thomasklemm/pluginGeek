require 'spec_helper'

shared_context "link" do
  let(:user)  { Fabricate(:user) }
  let(:staff) { Fabricate(:user, staff: true) }

  let(:link)  { Fabricate(:link) }
  let(:submitted_link) { Fabricate(:link, submitter: user) }
end

describe LinksController do
  it_should_behave_like "an authenticated controller", {
    index:   [:get],
    new:     [:get],
    create:  [:post],
    edit:    [:get, id: 1],
    update:  [:put, id: 1],
    destroy: [:delete, id: 1]
  }

  describe "#link_params" do
    let(:user)  { Fabricate(:user) }
    let(:staff) { Fabricate(:user, staff: true) }

    before do
      subject.params[:link] = {
        title: 'new_title',
        url: 'new_url',
        published_at: Date.current,
        repo_ids: [1, 2, 3],
        category_ids: [1, 2, 3]
      }
    end

    context "staff" do
      before { sign_in staff }
      let(:params) { controller.send(:link_params) }

      it "permits title" do
        expect(params[:title]).to be_present
      end

      it "permits url" do
        expect(params[:url]).to be_present
      end

      it "permits published_at" do
        expect(params[:published_at]).to be_present
      end

      it "permits repo_ids" do
        expect(params[:repo_ids]).to be_present
      end

      it "permits category_ids" do
        expect(params[:category_ids]).to be_present
      end
    end

    context "user" do
      before { sign_in user }
      let(:params) { controller.send(:link_params) }

      it "permits title" do
        expect(params[:title]).to be_present
      end

      it "permits url" do
        expect(params[:url]).to be_present
      end

      it "permits published_at" do
        expect(params[:published_at]).to be_present
      end

      it "permits repo_ids" do
        expect(params[:repo_ids]).to be_present
      end

      it "permits category_ids" do
        expect(params[:category_ids]).to be_present
      end
    end
  end
end

describe LinksController, "GET #index" do
  include_context "link"
  let!(:another_link) { Fabricate(:link) }

  shared_examples "links#index for user and staff" do
    before { get :index }

    it { should respond_with(:success) }
    it { should render_template(:index) }
    it { should_not set_the_flash }
  end

  context "user" do
    before { sign_in user }
    include_examples "links#index for user and staff"
  end

  context "staff" do
    before { sign_in staff }
    include_examples "links#index for user and staff"
  end
end

describe LinksController, "GET #new" do
  include_context "link"

  shared_examples "links#new for user and staff" do
    context "with new :url" do
      before { get :new, url: 'link_url', title: 'link_title' }

      let(:link) { assigns(:link) }

      it { should respond_with(:success) }
      it { should render_template(:new) }
      it { should_not set_the_flash }
      it { should authorize_resource }

      it "assigns a new link record to @link" do
        expect(link).to be_present
        expect(link).to be_new_record
      end

      it "assigns the link's title from the params" do
        expect(link.title).to eq('link_title')
      end

      it "assigns the current date as the default published_at" do
        expect(link.published_at).to eq(Date.current)
      end
    end

    context "with already known :url" do
      before { get :new, url: link.url }

      it { should_not set_the_flash }

      it "redirects to edit_link_path(@link)" do
        expect(response).to redirect_to edit_link_path(assigns(:link))
      end
    end
  end

  context "user" do
    before { sign_in user }
    include_examples "links#new for user and staff"
  end

  context "staff" do
    before { sign_in staff }
    include_examples "links#new for user and staff"
  end
end

describe LinksController, "POST #create" do
  include_context "link"

  let(:valid_link_attributes)   { Fabricate.attributes_for(:link)  }
  let(:invalid_link_attributes) { Fabricate.attributes_for(:link, url: "")  }

  shared_examples "links#create for user and staff" do
    context "valid link attributes" do
      before { post :create, link: valid_link_attributes }
      let(:link) { assigns(:link) }

      it { should redirect_to(edit_link_path(link)) }
      it { should set_the_flash.to('Link has been created.') }
      it { should authorize_resource }

      it "assigns the current user as the link's submitter" do
        expect(link.submitter).to eq(controller.current_user)
      end

      it "saves the link in the database" do
        expect(link).to be_persisted
      end
    end

    context "invalid link attributes" do
      before { post :create, link: invalid_link_attributes }
      let(:link) { assigns(:link) }

      it { should render_template(:new) }
      it { should_not set_the_flash }
      it { should authorize_resource }

      it "doesn't save the link in the database" do
        expect(link).to be_new_record
      end
    end
  end

  context "user" do
    before { sign_in user }
    include_examples "links#create for user and staff"
  end

  context "staff" do
    before { sign_in staff }
    include_examples "links#create for user and staff"
  end
end

describe LinksController, "GET #edit" do
  include_context "link"

  shared_examples "links#edit for user and staff" do
    before { get :edit, id: link }

    it { should respond_with(:success) }
    it { should render_template(:edit) }
    it { should_not set_the_flash }
    it { should authorize_resource }

    it "assigns and decorates @link" do
      expect(assigns(:link)).to be_present
      expect(assigns(:link)).to be_decorated
    end
  end

  context "user" do
    before { sign_in user }
    include_examples "links#edit for user and staff"
  end

  context "staff" do
    before { sign_in staff }
    include_examples "links#edit for user and staff"
  end
end

describe LinksController, "PUT #update" do
  include_context "link"

  let(:valid_link_attributes)   { Fabricate.attributes_for(:link)  }
  let(:invalid_link_attributes) { Fabricate.attributes_for(:link, url: "")  }

  shared_examples "links#update for user and staff" do
    context "valid link attributes" do
      before { put :update, id: link, link: valid_link_attributes }

      it { should redirect_to(edit_link_path(link)) }
      it { should set_the_flash.to('Link has been updated.') }
      it { should authorize_resource }

      it "saves the changes in the database" do
        expect(assigns(:link).url).to eq(valid_link_attributes[:url])
      end
    end

    context "invalid link attributes" do
      before { put :update, id: link, link: invalid_link_attributes }

      it { should render_template(:edit) }
      it { should_not set_the_flash }
      it { should authorize_resource }

      it "doesn't save the changes in the database" do
        assigns(:link).reload
        expect(assigns(:link).url).to eq(link.url)
        expect(assigns(:link).url).to_not eq(invalid_link_attributes[:url])
      end
    end
  end

  context "user" do
    before { sign_in user }
    include_examples "links#update for user and staff"
  end

  context "staff" do
    before { sign_in staff }
    include_examples "links#update for user and staff"
  end
end

describe LinksController, "DELETE #destroy" do
  include_context "link"

  shared_examples "links#destroy for link submitter and staff" do
    before { delete :destroy, id: submitted_link }

    it { should authorize_resource }
    it { should set_the_flash.to('Link has been destroyed.') }
    it { should redirect_to(root_path) }

    it "destroys the link" do
      expect(assigns(:link)).to be_destroyed
    end
  end

  context "user" do
    before do
      sign_in user
      request.env['HTTP_REFERER'] = 'where_i_came_from'
      delete :destroy, id: link
    end

    it { should authorize_resource }
    it { should redirect_to('where_i_came_from') }
    it { should set_the_flash.to(/not authorized/) }

    it "doesn't destroy the link" do
      expect(assigns(:link)).to be_persisted
    end
  end

  context "link submitter" do
    before { sign_in user }
    include_examples "links#destroy for link submitter and staff"
  end

  context "staff" do
    before { sign_in staff }
    include_examples "links#destroy for link submitter and staff"
  end
end
