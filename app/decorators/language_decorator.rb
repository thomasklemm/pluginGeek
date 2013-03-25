class LanguageDecorator < Draper::Decorator
  delegate_all
  decorates_association :categories
  decorates_association :repos
end
