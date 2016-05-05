module RailsTypedSettings
  class IncorrectType < StandardError ; end

  module TransformAttribute
    def self.included(base)
      base.define_singleton_method(:transform_attr) do |field, method|
        method = method.to_s
        base.class_eval <<-EOB
          define_method(method) do
            return nil unless #{field}
            @#{method} ||= untransform(#{field})
          end
          
          define_method("#{method}=") do |new_value|
            new_value = type_class.coerce(new_value)
            raise IncorrectType unless class_match(new_value)
            self.#{field} = transform(new_value)
            @#{method} = new_value
          end
        EOB
      end
    end
  end
end
