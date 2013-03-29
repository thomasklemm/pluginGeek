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

class LanguageClassification < ActiveRecord::Base
  belongs_to :language,
    touch: true

  # Category or repo
  belongs_to :classifier,
    polymorphic: true,
    touch: true

  validates :language, :classifier, presence: true
end
