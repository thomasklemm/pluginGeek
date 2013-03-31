require 'spec_helper'

describe UserDecorator do
  subject(:user) { Fabricate.build(:user).decorate }
  describe "#name", :focus do
    it "returns name when given" do
      user.name = 'Thomas'
      expect(user.name).to eq('Thomas')
    end

    it "falls back to returning login" do
      user.name = ""
      user.login = "thomasklemm"
      expect(user.name).to eq("thomasklemm")
    end
  end

  describe "#email" do

  end


  describe "#name" do

  end
  describe "#name" do

  end
  describe "#name" do

  end
  describe "#name" do

  end
  describe "#name" do

  end

end
