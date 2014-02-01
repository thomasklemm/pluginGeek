require 'spec_helper'

describe SubmissionsController, "GET #submit" do
  context "missing URL" do
    before { get :submit }

    it { should redirect_to(root_path) }
    it { should set_the_flash.to(/url/) }
  end

  context "URL pointing to a blog post etc." do
    before { get :submit, url: "http://link.to/an-interesting-post", title: "interesting post" }

    it { should_not set_the_flash }
    it "redirects to new_link_path" do
      expect(response).to redirect_to(
        new_link_path(url: "http://link.to/an-interesting-post", title: "interesting post"))
    end
  end

  context "URL (in various forms) pointing to a Github repo" do
    # Additional path elements and query strings
    # will be stripped
    valid_urls = [
      "https://github.com/owner/name",
      "https://github.com/owner/name?test=123",
      "https://github.com/owner/name/edit?test=123"
    ]

    context "repo exists" do
      let!(:repo) { Fabricate(:repo, owner: 'owner', name: 'name') }

      valid_urls.each do |url|
        before { get :submit, url: url }

        it { should_not set_the_flash }
        it "redirects to the repo" do
          expect(response).to redirect_to(repo)
        end
      end
    end

    context "repo does not exist" do
      valid_urls.each do |url|
        before { get :submit, url: url }

        it { should_not set_the_flash }
        it "redirects to new_repo_path" do
          expect(response).to redirect_to(new_repo_path(owner: 'owner', name: 'name'))
        end
      end
    end
  end
end
