require 'test_helper'
require 'set'

class RailsTypedSettingsTest < ActiveSupport::TestCase

  def setup
    Settings[:sale] = nil
    Settings[:sale_discount] = nil
    Settings[:sale_name] = nil
    Settings[:sale_start] = nil
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
    assert_equal(false, Settings[:sale])
    Settings[:sale] = true
    assert_equal(true, Settings[:sale])
  end

  test "setting to bad type raises exception" do
    assert_raises(RailsTypedSettings::Setting::IncorrectType) do
      Settings[:sale_discount] = "this is not a float"
    end
  end

  test "cache" do
    assert_equal(nil, Settings[:sale_name])
    assert_equal(1, Settings.cache.misses)

    Settings[:sale_name] = "sale!"
    assert_equal("sale!", Settings[:sale_name])
    assert_equal(2, Settings.cache.misses)
  end

  test "date times can be set with strings" do
    Settings[:sale_start] = "2015-05-01"
    assert_equal(DateTime, Settings[:sale_start].class)
    assert_equal(DateTime.parse("2015-05-01").to_s, Settings[:sale_start].to_s)
  end

  test "date times can be set with DateTime instances" do
    now = DateTime.now
    Settings[:sale_start] = now
    assert_equal(DateTime, Settings[:sale_start].class)
    assert_equal(now.to_s, Settings[:sale_start].to_s)
  end
  
  test "keys" do
    assert_equal(Set.new([:sale, :sale_discount, :sale_name, :sale_start]),
                 Settings.keys.to_set)
  end
  
  test "bools can be set with bool equivalents" do
    Settings[:sale] = 1
    assert_equal(true, Settings[:sale])

    Settings[:sale] = 0
    assert_equal(false, Settings[:sale])

    Settings[:sale] = "true"
    assert_equal(true, Settings[:sale])

    Settings[:sale] = "false"
    assert_equal(false, Settings[:sale])

    Settings[:sale] = "1"
    assert_equal(true, Settings[:sale])

    Settings[:sale] = "0"
    assert_equal(false, Settings[:sale])
  end
end
