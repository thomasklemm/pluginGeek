require 'spec_helper'

describe RepoUpdater do
  subject(:updater) { RepoUpdater.new }

  it { should be_kind_of(Sidekiq::Worker) }
  it { should respond_to(:perform) }

  describe "#update" do
    context "given a valid repo's full_name" do
      let(:repo) { Fabricate(:repo, full_name: 'rails/rails') }

      before do
        VCR.use_cassette('github/repos/rails', record: :new_episodes) do
          @result = updater.update(repo.full_name)
        end
      end

      it "updates the repo from Github" do
        repo.reload
        expect(repo.github_description).to be_present
        expect(repo.stars).to_not be_zero
      end

      it "marks the repo as successfully updated" do
        expect(repo.reload.update_success).to be_true
      end

      it "returns true" do
        expect(@result).to be_true
      end
    end

    context "given a non-existing repo's full_name" do
      context "existing repo where owner or name changes" do
      let(:repo) { Fabricate(:repo, full_name: 'unknown/unknown') }

      before do
        VCR.use_cassette('github/repos/unknown', record: :once) do
          @result = updater.update(repo.full_name)
        end
      end

        it "marks the repo as update failed" do
          repo.reload
          expect(repo).to be_persisted
          expect(repo.update_success).to be_false
        end

        it "returns false" do
          expect(@result).to be_false
        end
      end

      context "new repo that does not exist" do
        let(:repo) { Fabricate.build(:repo, full_name: 'unknown/unknown') }

        before do
          VCR.use_cassette('github/repos/unknown', record: :once) do
            @result = updater.update(repo.full_name)
          end
        end

        it "doesn't persist a repo" do
          expect { repo.reload }.to raise_error
          expect(repo).to be_new_record
        end

        it "returns false" do
          expect(@result).to be_false
        end
      end
    end
  end

  describe "#update_all" do
    it "updates all repos in serial" do
      Fabricate(:repo, full_name: "rails/rails")
      Fabricate(:repo, full_name: "twitter/bootstrap")

      updater.expects(:update).with("rails/rails")
      updater.expects(:update).with("twitter/bootstrap")

      Category.expects(:expire_all)

      updater.update_all
    end
  end
end
