#####################################################################
# test_tanh.rb
#
# Test cases for the Math.tanh method.
#####################################################################
require 'test/helper'
require 'test/unit'

class TC_Math_Tanh_SingletonMethod < Test::Unit::TestCase
  test "tanh basic functionality" do
    assert_respond_to(Math, :tanh)
    assert_nothing_raised{ Math.tanh(1) }
    assert_kind_of(Float, Math.tanh(1))
  end

  test "tanh with positive integer argument" do
    assert_nothing_raised{ Math.tanh(1) }
    assert_in_delta(0.76, Math.tanh(1), 0.01)
  end

  test "tanh with zero argument" do
    assert_nothing_raised{ Math.tanh(0) }
    assert_in_delta(0.0, Math.tanh(0), 0.01)
  end

  test "tanh with negative integer argument" do
    assert_nothing_raised{ Math.tanh(-1) }
    assert_in_delta(-0.76, Math.tanh(-1), 0.01)
  end

  test "tanh with positive float argument" do
    assert_nothing_raised{ Math.tanh(0.345) }
    assert_in_delta(0.33, Math.tanh(0.345), 0.01)
  end

  test "tanh with negative float argument" do
    assert_nothing_raised{ Math.tanh(-0.345) }
    assert_in_delta(-0.33, Math.tanh(-0.345), 0.01)
  end

  test "tanh requires a numeric argument" do
    assert_raises(TypeError){ Math.tanh(nil) }
    assert_raises(TypeError){ Math.tanh('test') }
  end

  test "tanh takes one argument only" do
    assert_raise(ArgumentError){ Math.tanh }
    assert_raise(ArgumentError){ Math.tanh(1,1) }
  end
end
