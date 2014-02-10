class PlatformDecorator < Draper::Decorator
  delegate_all
  decorates_association :categories
end
