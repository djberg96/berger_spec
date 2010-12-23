################################################################
# tc_shift.rb
#
# Test suite for the Array#shift instance method.
################################################################
require 'test/helper'
require 'test/unit'

class TC_Array_Shift_InstanceMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @array = %w/a b c/
  end

  test "shift basic behavior" do
    assert_respond_to(@array, :shift)
    assert_nothing_raised{ @array.shift }
  end

  test "shift returns expected results" do
    assert_equal("a", @array.shift)
    assert_equal("b", @array.shift)
    assert_equal("c", @array.shift)
  end

  test "shift returns nil if called on an empty array" do
    assert_equal(nil, [].shift)
  end

  test "shift returns nested array instance properly" do
    assert_equal(['a'], [['a'], ['b']].shift)
  end

  test "shift returns nil if array contains nil" do
    assert_equal(nil, [nil].shift)
  end

  test "shift returns 0 if array contains zero" do
    assert_equal(0, [0].shift)
  end

  test "shift returns false if array contains false" do
    assert_equal(false, [false].shift)
  end

  test "shift returns true if array contains true" do
    assert_equal(true, [true].shift)
  end

  test "shift returns nested empty array if it contains empty nested arrays" do
    assert_equal([], [[],[]].shift)
  end

  # As of 1.8.7 Array#shift accepts an argument

  if RELEASE > 6
    test "shift accepts an optional argument" do
      assert_nothing_raised{ @array.shift(2) }
    end

    test "shift with a numeric argument returns the expected results" do
      assert_equal(['a'], %w[a b c].shift(1))
      assert_equal(['a', 'b'], %w[a b c].shift(2))
      assert_equal(['a', 'b', 'c'], %w[a b c].shift(3))
    end

    test "shift with a numeric argument larger than the receiver size returns the expected results" do
      assert_equal(['a', 'b', 'c'], %w[a b c].shift(4))
      assert_equal(['a', 'b', 'c'], %w[a b c].shift(99))
    end

    test "passing an argument of zero to shift returns an empty array" do
      assert_equal([], @array.shift(0))
    end

    test "an argument to shift must be a number if present" do
      assert_raise(TypeError){ @array.shift('test') }
      assert_raise(TypeError){ @array.shift(nil) }
    end

    test "an numeric argument must be positive if present" do
      assert_raise(ArgumentError){ @array.shift(-1) }
    end
  else
    test "shift does not accept any arguments" do
      assert_raises(ArgumentError){ @array.shift("foo") }
      assert_raises(ArgumentError){ @array.shift(2) }
    end
  end

  def teardown
    @array = nil
  end
end
