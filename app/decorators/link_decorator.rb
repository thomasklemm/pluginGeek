class LinkDecorator < Draper::Decorator
  delegate_all

  decorates_association :repos
  decorates_association :extended_categories
end
