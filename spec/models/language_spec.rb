require 'spec_helper'

describe Language do
  subject(:language) { Fabricate.build(:language) }
  it { should be_valid }

  it { should validate_presence_of(:name) }

  it "has a friendly id using the name" do
    language.name = 'web design'
    expect(language.to_param).to eq('web design')
  end

  it "allows a tree structure" do
    language.save
    sublanguage = Fabricate.build(:language)
    language.children << sublanguage

    expect(language).to have(1).children
    expect(language).to be_root
    expect(sublanguage.parent).to eq(language)
  end

  it { should have_many(:language_classifications).dependent(:destroy) }
  it { should have_many(:categories).through(:language_classifications) }
  it { should have_many(:repos).through(:language_classifications) }
end
