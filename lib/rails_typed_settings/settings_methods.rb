module RailsTypedSettings
  module SettingsMethods
    def self.included?(base)
      base.define_instance_method(:cache) do
        @cache ||= {}
      end
      
      base.define_instance_method(:setting) do |var_name, var_type, opts|
        opts ||= {}
      end

      base.define_instance_method(:read_setting) do |var_name|
        setting_entry = cache[var_name]
        if setting_entry.nil?
          raise NoSuchSetting
        end

        if setting_entry.value.nil?
          setting_entry.value = read_db(var_name)
        end

        setting_entry.value
      end

      base.define_instance_method(:read_db) do |var_name|
        s = Setting.find_by(var_name: var_name) or raise NoSuchSetting
        s.transformed_value
      end

      base.define_instance_method(:write_db) do |var_name, value|
        s = Setting.find_or_create_by(var_name: var_name) do |s|
          s.value = backing
        end
      end

      base.define_instance_method(:write_setting) do |var_name, value|
        setting_entry = cache[var_name]
        
        if setting_entry.nil?
          raise NoSuchSetting
        end

        if result = write_db(var_name, value)
          setting_entry.value = value
        end

        result
      end
      
      base.define_instance_method(:[]) do |var_name|
        read_setting(var_name)
      end

      base.define_instance_method(:[]=) do |var_name, value|
        write_setting(var_name, value)
      end
    end
  end
end
