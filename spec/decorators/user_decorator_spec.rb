require 'spec_helper'

describe UserDecorator do
  subject(:user) { Fabricate.build(:user).decorate }

  describe "#name" do
    it "returns user's name when given" do
      user.name = "Thomas"
      expect(user.name).to eq("Thomas")
    end

    it "returns user's login when name is not present" do
      user.name = ""
      user.login = "thomasklemm"
      expect(user.name).to eq("thomasklemm")
    end
  end

  describe "#email" do
    it "returns the user's email when given" do
      user.email = "email"
      expect(user.email).to eq("email")
    end

    it "returns an empty string if missing" do
      expect(user.email).to eq("")
    end
  end

  describe "#company" do
    it "returns the user's company when given" do
      user.company = "company"
      expect(user.company).to eq("company")
    end

    it "returns an empty string if missing" do
      expect(user.company).to eq("")
    end
  end

  describe "#location" do
    it "returns the user's location when given" do
      user.location = "location"
      expect(user.location).to eq("location")
    end

    it "returns an empty string if missing" do
      expect(user.location).to eq("")
    end
  end

  describe "#followers" do
    it "returns the user's follower count when given" do
      user.followers = 100
      expect(user.followers).to eq(100)
    end

    it "returns 0 if missing" do
      expect(user.followers).to eq(0)
    end
  end

  describe "#avatar_url" do
    it "returns the user's avatar_url when given" do
      user.avatar_url = "avatar_url"
      expect(user.avatar_url).to eq("avatar_url")
    end

    it "returns the url of the default avatar if missing" do
      expect(user.avatar_url).to eq(user.class::DEFAULT_AVATAR_URL)
    end
  end

  describe "#github_url" do
    it "returns the url for the user's profile on Github" do
      user.login = "thomasklemm"
      expect(user.github_url).to eq("https://github.com/thomasklemm")
    end
  end
end
