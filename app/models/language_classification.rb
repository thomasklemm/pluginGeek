class LanguageClassification < ActiveRecord::Base
  belongs_to :language,
    touch: true

  # Category or repo
  belongs_to :classifier,
    polymorphic: true,
    touch: true
end
