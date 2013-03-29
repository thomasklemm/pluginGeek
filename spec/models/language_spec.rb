# == Schema Information
#
# Table name: languages
#
#  created_at :datetime         not null
#  id         :integer          not null, primary key
#  name       :text
#  parent_id  :integer
#  slug       :text
#  updated_at :datetime         not null
#
# Indexes
#
#  index_languages_on_slug  (slug) UNIQUE
#

require 'spec_helper'

describe Language do
  subject(:language) { Fabricate.build(:language) }
  it { should be_valid }

  it { should validate_presence_of(:name) }

  it "has a friendly id using the name" do
    language.save
    expect(language.to_param).to eq(language.name.parameterize)
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
