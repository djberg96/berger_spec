#####################################################################
# test_asinh.rb
#
# Test cases for the Math.asinh method.
#####################################################################
require 'test/helper'
require 'test/unit'

class TC_Math_Asinh_SingletonMethod < Test::Unit::TestCase
  test "asinh basic functionality" do
    assert_respond_to(Math, :asinh)
    assert_nothing_raised{ Math.asinh(1) }
    assert_kind_of(Float, Math.asinh(1))
  end

  test "asinh with positive integer argument" do
    assert_nothing_raised{ Math.asinh(1) }
    assert_nothing_raised{ Math.asinh(100) }
    assert_in_delta(0.88, Math.asinh(1), 0.01)
  end

  test "asinh with zero argument" do
    assert_nothing_raised{ Math.asinh(0) }
    assert_equal(0.0, Math.asinh(0))
  end

  test "asinh with negative integer argument" do
    assert_nothing_raised{ Math.asinh(-1) }
    assert_nothing_raised{ Math.asinh(-100) }
    assert_in_delta(-0.88, Math.asinh(-1), 0.01)
  end

  test "asinh with positive float argument" do
    assert_nothing_raised{ Math.asinh(0.345) }
    assert_in_delta(0.338, Math.asinh(0.345), 0.01)
  end

  test "asinh with negative float argument" do
    assert_nothing_raised{ Math.asinh(-0.345) }
    assert_in_delta(-0.338, Math.asinh(-0.345), 0.01)
  end

  test "asinh requires a numeric argument" do
    assert_raises(TypeError){ Math.asinh('test') }
  end

  test "asinh requires a single argument only" do
    assert_raises(ArgumentError){ Math.asinh(1,1) }
  end
end
