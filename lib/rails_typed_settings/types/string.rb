module RailsTypedSettings
  module Types
    class String < Base
      def self.===(value)
        ::String === value
      end

      def self.coerce(value)
        return nil if value.nil?
        value.to_s
      end
    end
  end
end
