######################################################
# tc_index.rb
#
# Test suite for the Array#index instance method.
######################################################
require 'test/helper'
require "test/unit"

class TC_Array_Index_InstanceMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @array = [1, "two", nil, false, true]
  end

  test "index basic functionality" do
    assert_respond_to(@array, :index)
    assert_nothing_raised{ @array.index(1) }
  end

  test "index returns expected results" do
    assert_equal(0, @array.index(1))
    assert_equal(1, @array.index("two"))
    assert_equal(2, @array.index(nil))
    assert_equal(3, @array.index(false))
    assert_equal(4, @array.index(true))
    assert_equal(nil, @array.index(99))
  end

  test "index accepts a maximum of one argument" do
    assert_raises(ArgumentError){ @array.index(0,1) }
  end

  if PRE187
    test "index requires at least one argument" do
      assert_raises(ArgumentError){ @array.index }
    end
  else
    test "index returns an enumerator if no argument is provided" do
      assert_kind_of(Enumerable::Enumerator, @array.index)
    end
  end

  def teardown
    @array = nil
  end
end
