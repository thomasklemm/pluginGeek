require 'spec_helper'

describe RepoUpdater do
  subject(:updater) { RepoUpdater.new }

  it { should be_kind_of(Sidekiq::Worker) }

  describe "#perform(full_name)" do
    context "with valid repo full_name" do
      pending
    end

    context "with non-existent repo full_name" do
      pending
    end
  end

  describe "#update_all" do
    it "updates all repos in serial" do
      Fabricate(:repo, full_name: "rails/rails")
      Fabricate(:repo, full_name: "twitter/bootstrap")

      updater.expects(:perform).with("rails/rails").returns(true)
      updater.expects(:perform).with("twitter/bootstrap").returns(true)

      Category.expects(:expire_all).returns(true)

      updater.update_all
    end
  end
end
