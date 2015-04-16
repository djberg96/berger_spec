#####################################################################
# test_tan.rb
#
# Test cases for the Math.tan method.
#####################################################################
require 'test/helper'
require 'test/unit'

class TC_Math_Tan_SingletonMethod < Test::Unit::TestCase
  test "tan basic functionality" do
    assert_respond_to(Math, :tan)
    assert_nothing_raised{ Math.tan(1) }
    assert_kind_of(Float, Math.tan(1))
  end

  test "tan with positive integer argument" do
    assert_nothing_raised{ Math.tan(1) }
    assert_in_delta(1.55, Math.tan(1), 0.01)
  end

  test "tan with zero argument" do
    assert_nothing_raised{ Math.tan(0) }
    assert_in_delta(0.0, Math.tan(0), 0.01)
  end

  test "tan with negative integer argument" do
    assert_nothing_raised{ Math.tan(-1) }
    assert_in_delta(-1.55, Math.tan(-1), 0.01)
  end

  test "tan with positive float argument" do
    assert_nothing_raised{ Math.tan(0.345) }
    assert_in_delta(0.35, Math.tan(0.345), 0.01)
  end

  test "tan with negative float argument" do
    assert_nothing_raised{ Math.tan(-0.345) }
    assert_in_delta(-0.35, Math.tan(-0.345), 0.01)
  end

  test "tan requires a numeric argument" do
    assert_raises(TypeError){ Math.tan(nil) }
    assert_raises(TypeError){ Math.tan('test') }
  end

  test "tan takes one argument only" do
    assert_raise(ArgumentError){ Math.tan }
    assert_raise(ArgumentError){ Math.tan(1,1) }
  end
end
