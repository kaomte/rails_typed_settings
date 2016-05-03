require 'test_helper'
require 'set'

class RailsTypedSettingsTest < ActiveSupport::TestCase

  def setup
    Settings[:sale] = nil
    Settings[:sale_discount] = nil
    Settings[:sale_name] = nil
    Settings.cache.clear
  end

  # Cannot create a new setting without a type
  test "trying to create a new setting raises exception" do
    assert_raises(ActiveRecord::RecordNotFound) do
      Settings[:new_setting] = "new value"
    end
  end

  test "setting with no default should be nil" do
    assert_equal(false, Settings.is_set?(:sale_name))
    assert_equal(nil, Settings[:sale_name])
  end
  
  test "read a setting default" do
    assert_equal(false, Settings.is_set?(:sale_discount))
    assert_equal(0.3, Settings[:sale_discount])
  end

  test "write a setting" do
    assert_nil(Settings[:sale])
    Settings[:sale] = true
    assert(Settings[:sale])
  end

  test "setting to bad type raises exception" do
    assert_raises(RailsTypedSettings::Setting::IncorrectType) do
      Settings[:sale] = "this is not a bool"
    end
  end

  test "cache" do
    assert_equal(nil, Settings[:sale_name])
    assert_equal(1, Settings.cache.misses)

    Settings[:sale_name] = "sale!"
    assert_equal("sale!", Settings[:sale_name])
    assert_equal(2, Settings.cache.misses)
  end

  test "keys" do
    assert_equal(Set.new([:sale, :sale_discount, :sale_name]),
                 Settings.keys.to_set)
  end
end
