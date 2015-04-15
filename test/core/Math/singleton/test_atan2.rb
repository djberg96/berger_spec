#####################################################################
# test_atan2.rb
#
# Test cases for the Math.atan2 method.
#####################################################################
require 'test/helper'
require 'test/unit'

class TC_Math_Atan2_SingletonMethod < Test::Unit::TestCase
  test "atan2 basic functionality" do
    assert_respond_to(Math, :atan2)
    assert_nothing_raised{ Math.atan2(0, 1) }
    assert_kind_of(Float, Math.atan2(0, 1))
  end

  test "atan2 with positive integer argument" do
    assert_nothing_raised{ Math.atan2(1, 2) }
    assert_nothing_raised{ Math.atan2(1, 100) }
    assert_in_delta(0.463, Math.atan2(1, 2), 0.01)
  end

  test "atan2 with zero argument" do
    assert_nothing_raised{ Math.atan2(0, 0) }
    assert_equal(0.0, Math.atan2(0, 0))
  end

  test "atan2 with negative argument" do
    assert_nothing_raised{ Math.atan2(-2, -1) }
    assert_nothing_raised{ Math.atan2(-1, -2) }
    assert_nothing_raised{ Math.atan2(-2, -100) }
    assert_in_delta(-2.03, Math.atan2(-2, -1), 0.01)
  end

  test "atan2 with positive float argument" do
    assert_nothing_raised{ Math.atan2(0.345, 0.745) }
    assert_in_delta(0.433, Math.atan2(0.345, 0.745), 0.01)
  end

  test "atan2 with negative float argument" do
    assert_nothing_raised{ Math.atan2(-0.345, -0.745) }
    assert_in_delta(-2.70, Math.atan2(-0.345, -0.745), 0.01)
  end

  test "atan2 requires numeric arguments" do
    assert_raise(TypeError){ Math.atan2(1, 'test') }
    assert_raise(TypeError){ Math.atan2('test', 1) }
  end

  test "atan2 requires two arguments only" do
    assert_raise(ArgumentError){ Math.atan2 }
    assert_raise(ArgumentError){ Math.atan2(1) }
    assert_raise(ArgumentError){ Math.atan2(1,1,1) }
  end
end
