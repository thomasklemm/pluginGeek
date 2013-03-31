require 'spec_helper'

describe LanguageDecorator do
  subject(:language) do
    language = Fabricate.build(:language)
    language.decorate
  end

  it "decorates associated categories" do
    expect(language.categories).to be_decorated
  end

  it "decorates associated repos" do
    expect(language.repos).to be_decorated
  end
end
