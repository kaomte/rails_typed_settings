module RailsTypedSettings
  module Types
    class Integer < Base
      def self.===(value)
        ::Integer === value
      end
    end
  end
end
