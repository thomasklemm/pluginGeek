class LinkDecorator < Draper::Decorator
  delegate_all
  decorates_associations :repos, :categories
end