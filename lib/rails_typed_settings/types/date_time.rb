module RailsTypedSettings
  module Types
    class DateTime < Base
      FMT = "%Y-%m-%dT%H:%M:%S%z"
      
      def self.===(value)
        ::DateTime === value
      end

      def self.coerce(value)
        return nil if value.nil?

        if value.is_a? ::String
          ::DateTime.parse(value)
        else
          value
        end
      end

      def self.transform(value)
        value.strftime(FMT)
      end
      
      def self.untransform(value)
        ::DateTime.strptime(value, FMT)
      end
    end
  end
end
