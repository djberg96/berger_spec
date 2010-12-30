######################################################
# tc_rindex.rb
#
# Test suite for the Array#rindex instance method.
######################################################
require 'test/helper'
require 'test/unit'

class TC_Array_RIndex_InstanceMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @array = [1, "two", nil, false, true, "two", nil]
  end

  test "rindex basic functionality" do
    assert_respond_to(@array, :rindex)
    assert_nothing_raised{ @array.rindex(1) }
  end

  test "rindex returns the expected results" do
    assert_equal(0, @array.rindex(1))
    assert_equal(5, @array.rindex("two"))
    assert_equal(6, @array.rindex(nil))
    assert_equal(3, @array.rindex(false))
    assert_equal(4, @array.rindex(true))
  end

  test "rindex returns nil if the value is not found" do
    assert_equal(nil, @array.rindex(99))
  end

  if RELEASE < 7
    test "rindex requires one argument only" do
      assert_raises(ArgumentError){ @array.rindex }
      assert_raises(ArgumentError){ @array.rindex(0, 1) }
    end
  end

  def teardown
    @array = nil
  end
end
