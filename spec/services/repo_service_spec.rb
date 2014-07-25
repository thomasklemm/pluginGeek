require 'spec_helper'

describe RepoService do
  let(:repo) { build(:repo) }
  subject(:service) { RepoService.new(repo) }

  describe "#fetch_and_create_or_update" do
    context "with valid owner_and_name" do
      before do
        repo.owner_and_name = 'rails/rails'
        VCR.use_cassette('github/repos/rails/rails') { @result = service.fetch_and_create_or_update }
        repo.reload
      end

      it "creates or updates, saves and returns the repo" do
        expect(@result).to be_a(Repo)
        expect(@result).to be_persisted
        expect(@result.owner_and_name).to eq('rails/rails')
      end

      it "assigns the repo's fields from the Github response" do
        expect(repo.owner_and_name).to    be_present
        expect(repo.description).to       be_present
        expect(repo.stars).not_to         be_zero
        expect(repo.homepage_url).to      be_present
        expect(repo.github_updated_at).to be_present
      end

    end

    context "with invalid owner_and_name" do
      before { repo.owner_and_name = 'unknown/unknown' }
      it "returns false" do
        VCR.use_cassette('github/repos/unknown/unknown') do
          expect(service.fetch_and_create_or_update).to be false
        end
      end
    end
  end
end
