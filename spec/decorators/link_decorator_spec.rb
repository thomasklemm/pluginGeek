require 'spec_helper'

describe LinkDecorator do
  subject(:link) do
    link = Fabricate.build(:link)
    link.decorate
  end

  it "decorates associated repos" do
    expect(link.repos).to be_decorated
  end

  it "decorates associated extended_categories" do
    expect(link.extended_categories).to be_decorated
  end
end
