module RailsTypedSettings
  class Base
    TYPES = {
      float: Float,
      integer: Integer,
      string: String,
      datetime: DateTime,
      boolean: [TrueClass, FalseClass]
    }
    
    CACHE = Cache.new(20) do |k|
      Setting.find_by(var_name: k.to_s).try(:value)
    end
    
    class << self
      def types
        TYPES
      end

      def cache
        CACHE
      end

      # Adds a db entry for the setting
      def setting(var_name, var_type, opts = {})
        unless Setting.find_by(var_name: var_name.to_s)
          s = Setting.create(var_name: var_name.to_s, var_type: var_type.to_s)
          s.d_val = opts[:default] if opts[:default]
          s.save!
        end
      end

      def [](v_name)
        CACHE.value(v_name.to_s)
      end

      def []=(v_name, value)
        s = Setting.find_by!(var_name: v_name.to_s)
        s.value = value
        CACHE.remove(v_name.to_s)
        s.save!
      end

      def keys
        Setting.all.map {|s| s.var_name.to_sym }
      end
      
      def is_set?(v_name)
        s = Setting.find_by(var_name: v_name)
        s && s.is_set?
      end
    end
  end
end
