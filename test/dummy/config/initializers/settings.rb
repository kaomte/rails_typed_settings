class Settings < RailsTypedSettings::Base
  setting :sale, :boolean, :default => false
  setting :sale_discount, :float, :default => 0.3
  setting :sale_start, :datetime
  setting :sale_name, :string
end

