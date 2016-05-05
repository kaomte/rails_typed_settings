module RailsTypedSettings
  module Types
    class Integer < Base
      def self.===(value)
        ::Integer === value
      end

      def self.coerce(value)
        return nil if value.nil?

        if value.is_a? ::String
          return value.to_i
        end

        value
      end
    end
  end
end
