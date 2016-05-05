module RailsTypedSettings
  module Types
    class Boolean < Base
      def self.===(value)
        TrueClass === value || FalseClass === value
      end

      def self.coerce(value)
        return nil if value.nil?
        return false if [false, "false", "0", 0].include?(value)
        true
      end
    end
  end
end
