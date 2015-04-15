#####################################################################
# test_atan.rb
#
# Test cases for the Math.atan method.
#####################################################################
require 'test/helper'
require 'test/unit'

class TC_Math_Atan_SingletonMethod < Test::Unit::TestCase
  test "atan basic functionality" do
    assert_respond_to(Math, :atan)
    assert_nothing_raised{ Math.atan(1) }
    assert_kind_of(Float, Math.atan(1))
  end

  test "atan with positive integer argument" do
    assert_nothing_raised{ Math.atan(1) }
    assert_nothing_raised{ Math.atan(100) }
    assert_in_delta(0.785, Math.atan(1), 0.01)
  end

  test "atan with zero argument" do
    assert_nothing_raised{ Math.atan(0) }
    assert_equal(0.0, Math.atan(0))
  end

  test "atan with negative integer argument" do
    assert_nothing_raised{ Math.atan(-1) }
    assert_nothing_raised{ Math.atan(-100) }
    assert_in_delta(-0.785, Math.atan(-1), 0.01)
  end

  test "atan with positive float argument" do
    assert_nothing_raised{ Math.atan(0.345) }
    assert_in_delta(0.332, Math.atan(0.345), 0.01)
  end

  test "atan with negative float argument" do
    assert_nothing_raised{ Math.atan(-0.345) }
    assert_in_delta(-0.332, Math.atan(-0.345), 0.01)
  end

  test "argument to atan must be numeric" do
    assert_raise(TypeError){ Math.atan('test') }
  end

  test "atan requires one argument only" do
    assert_raise(ArgumentError){ Math.atan }
    assert_raise(ArgumentError){ Math.atan(1,1) }
  end
end
