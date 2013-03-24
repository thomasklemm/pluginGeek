# == Schema Information
#
# Table name: categorizations
#
#  category_id :integer          not null
#  id          :integer          not null, primary key
#  repo_id     :integer          not null
#
# Indexes
#
#  index_categorizations_on_category_id              (category_id)
#  index_categorizations_on_repo_id                  (repo_id)
#  index_categorizations_on_repo_id_and_category_id  (repo_id,category_id)
#

require 'spec_helper'

describe Categorization do
  subject { Fabricate.build(:categorization) }
  it { should be_valid }

  it { should belong_to(:repo) }
  it { should belong_to(:category) }

  it { should validate_presence_of(:repo) }
  it { should validate_presence_of(:category) }
end
