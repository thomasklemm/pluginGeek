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
        Platform::Global.global_id?(id) ? global : find(id)
      end

      def global
        Platform::Global.instance
      end
    end
  end
end
