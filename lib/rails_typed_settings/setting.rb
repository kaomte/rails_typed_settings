module RailsTypedSettings
  class Setting < ActiveRecord::Base
    include RailsTypedSettings::TransformAttribute
    
    class IncorrectType < StandardError ; end

    transform_attr :transformed_value, :val
    transform_attr :default_transformed_value, :d_val

    def value
      val || d_val
    end

    def value=(new_value)
      self.val = new_value
    end
    
    def is_set?
      !transformed_value.nil?
    end
    
    private

    def class_match(v)
      return true if v.nil?
      return type_class.any? {|tc| tc === v } if Array === type_class
      type_class === v
    end
    
    def type_class
      RailsTypedSettings::Base::TYPES[var_type.to_sym]
    end

    def transform(value)
      return nil if value.nil?
      JSON.dump(value)
    end

    def untransform(t_value)
      JSON.load(t_value)
    end
  end
end
