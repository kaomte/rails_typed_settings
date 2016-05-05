module RailsTypedSettings
  module Types
    class Float < Base
      def self.===(value)
        ::Float === value
      end
    end
  end
end
  
