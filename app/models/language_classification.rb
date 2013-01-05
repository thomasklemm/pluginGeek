# == Schema Information
# Schema version: 20121217150850
#
# Table name: language_classifications
#
#  id              :integer          not null, primary key
#  language_id     :integer          not null
#  classifier_id   :integer          not null
#  classifier_type :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_language_classifications_on_classifier   (classifier_id,classifier_type)
#  index_language_classifications_on_language_id  (language_id)
#

class LanguageClassification < ActiveRecord::Base
  belongs_to :language,
    touch: true
  belongs_to :classifier, # category or repo
    polymorphic: true,
    touch: true
end
