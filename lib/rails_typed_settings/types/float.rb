module RailsTypedSettings
  module Types
    class Float < Base
      def self.===(value)
        ::Float === value
      end

      def self.coerce(value)
        return nil if value.nil?
        if [::String, ::Integer, Fixnum].include? value.class
          return value.to_f
        end

        value
      end
    end
  end
end
  
