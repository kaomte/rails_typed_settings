module RailsTypedSettings
  module Types
    class Base
      def self.coerce(value)
        value
      end

      # Performs any encoding to db storage format
      def self.transform(value)
        JSON.dump(value)
      end
      
      # Performs any decoding from db storage format
      def self.untransform(value)
        JSON.load(value)
      end
    end
  end
end
