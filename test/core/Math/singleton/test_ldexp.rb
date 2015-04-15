#####################################################################
# test_ldexp.rb
#
# Test cases for the Math.ldexp method.
#####################################################################
require 'test/helper'
require 'test/unit'

class TC_Math_Ldexp_SingletonMethod < Test::Unit::TestCase
  test "ldexp basic functionality" do
    assert_respond_to(Math, :ldexp)
    assert_nothing_raised{ Math.ldexp(1, 2) }
    assert_kind_of(Float, Math.ldexp(1, 2))
  end

  test "ldexp with positive integer arguments" do
    assert_nothing_raised{ Math.ldexp(1, 2) }
    assert_in_delta(4.0, Math.ldexp(1, 2), 0.01)
  end

  test "ldexp with zero argument" do
    assert_nothing_raised{ Math.ldexp(0, 0) }
    assert_in_delta(0.0, Math.ldexp(0, 0), 0.01)
  end

  test "ldexp with negative integer arguments" do
    assert_nothing_raised{ Math.ldexp(-1, -2) }
    assert_in_delta(-0.25, Math.ldexp(-1, -2), 0.01)
  end

  test "ldexp with positive float arguments" do
    assert_nothing_raised{ Math.ldexp(0.345, 0.655) }
    assert_in_delta(0.345, Math.ldexp(0.345, 0.655), 0.01)
  end

  test "ldexp with negative float arguments" do
    assert_nothing_raised{ Math.ldexp(-0.345, -0.655) }
    assert_in_delta(-0.345, Math.ldexp(-0.345, -0.655), 0.01)
  end

  test "ldexp requires numeric arguments" do
    assert_raises(TypeError){ Math.ldexp(nil, 1) }
    assert_raises(TypeError){ Math.ldexp(1, nil) }
  end

  test "ldexp requires two arguments" do
    assert_raises(ArgumentError){ Math.ldexp }
    assert_raises(ArgumentError){ Math.ldexp(0) }
    assert_raises(ArgumentError){ Math.ldexp(0,1,2) }
  end
end
