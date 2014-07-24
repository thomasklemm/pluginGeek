class Platform
  module StaticMethods
    extend ActiveSupport::Concern

    module ClassMethods
      # Defines:
      #  Platform.ruby # => Ruby platform
      #  Platform.javascript # => JavaScript platform
      PLATFORMS.each do |platform_attributes|
        define_method platform_attributes[:id] do
          new(platform_attributes)
        end
      end

      def all
        PLATFORM_IDS.map(&method(:find))
      end

      def find(id)
        send(id)
      end

      def current(id)
        find(id) || global
      end

      def global
        GlobalPlatform.new
      end
    end
  end
end
