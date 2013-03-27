require 'spec_helper'

describe SubmissionsController, "GET #submit" do
  context "without :url param" do
    before { get :submit }

    it { should redirect_to(root_path) }
    it { should set_the_flash.to(/url/) }
  end

  context "with :url pointing to a repo on Github" do
    context "existing repo" do
      let!(:repo) { Fabricate(:repo, owner: 'rails', name: 'rails') }
      before { get :submit, url: "https://github.com/rails/rails" }

      it { should_not set_the_flash }
      it "redirects to the repo" do
        expect(response).to redirect_to(repo)
      end
    end

    context "new repo" do
      before { get :submit, url: "https://github.com/rails/rails" }

      it { should_not set_the_flash }
      it "redirects to new_repo_path" do
        expect(response).to redirect_to(new_repo_path(owner: 'rails', name: 'rails'))
      end
    end
  end

  context "with :url pointing to an interesting blog post" do
    before { get :submit, url: "http://link.to/an-interesting-post", title: "interesting post" }

    it { should_not set_the_flash }
    it "redirects to new_link_path" do
      expect(response).to redirect_to(
        new_link_path(url: "http://link.to/an-interesting-post", title: "interesting post"))
    end
  end
end
