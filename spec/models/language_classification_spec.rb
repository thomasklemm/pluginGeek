# == Schema Information
#
# Table name: language_classifications
#
#  classifier_id   :integer          not null
#  classifier_type :text             not null
#  created_at      :datetime         not null
#  id              :integer          not null, primary key
#  language_id     :integer          not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_language_classifications_on_classifier   (classifier_id,classifier_type)
#  index_language_classifications_on_language_id  (language_id)
#

require 'spec_helper'

describe LanguageClassification do
  subject { Fabricate.build(:language_classification) }
  it { should be_valid }

  it { should belong_to(:language) }
  it { should belong_to(:classifier) }

  it { should validate_presence_of(:language) }
  it { should validate_presence_of(:classifier) }
end
