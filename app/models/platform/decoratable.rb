class Platform
  module Decoratable
    extend ActiveSupport::Concern

    include Draper::Decoratable

    module ClassMethods
      def decorator_class
        PlatformDecorator
      end
    end
  end
end

