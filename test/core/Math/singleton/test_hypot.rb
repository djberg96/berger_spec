#####################################################################
# test_hypot.rb
#
# Test cases for the Math.hypot method.
#####################################################################
require 'test/helper'
require 'test/unit'

class TC_Math_Hypot_SingletonMethod < Test::Unit::TestCase
  test "hypot basic functionality" do
    assert_respond_to(Math, :hypot)
    assert_nothing_raised{ Math.hypot(1, 2) }
    assert_kind_of(Float, Math.hypot(1, 2))
  end

  test "hypot with positive integer arguments" do
    assert_nothing_raised{ Math.hypot(1, 2) }
    assert_in_delta(2.23, Math.hypot(1, 2), 0.01)
  end

  test "hypot with zero arguments" do
    assert_nothing_raised{ Math.hypot(0, 0) }
    assert_in_delta(0.0, Math.hypot(0, 0), 0.01)
  end

  test "hypot with negative integer arguments" do
    assert_nothing_raised{ Math.hypot(-1, -2) }
    assert_in_delta(2.23, Math.hypot(-1, -2), 0.01)
  end

  test "hypot with positive float arguments" do
    assert_nothing_raised{ Math.hypot(0.345, 0.655) }
    assert_in_delta(0.74, Math.hypot(0.345, 0.655), 0.01)
  end

  test "hypot with negative float arguments" do
    assert_nothing_raised{ Math.hypot(-0.345, -0.655) }
    assert_in_delta(0.74, Math.hypot(-0.345, -0.655), 0.01)
  end

  test "hypot requires numeric arguments" do
    assert_raises(TypeError){ Math.hypot(nil, 1) }
    assert_raises(TypeError){ Math.hypot(1, nil) }
  end

  test "hypot requires two arguments" do
    assert_raises(ArgumentError){ Math.hypot }
    assert_raises(ArgumentError){ Math.hypot(0) }
    assert_raises(ArgumentError){ Math.hypot(0, 1, 2) }
  end
end
