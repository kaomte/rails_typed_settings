require 'test_helper'
class Settings
  include SettingsMethods
  
  setting :global_sale, :boolean, :default => true
  setting :global_sale_discount, :float, :default => .3
  setting :glboal_sale_name, :string
end

class RailsTypedSettingsTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, RailsTypedSettings
  end
end
