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

Fabricator(:language_classification) do
  language
  classifier { Fabricate(:category) }
end