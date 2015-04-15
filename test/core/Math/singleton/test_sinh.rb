#####################################################################
# test_sinh.rb
#
# Test cases for the Math.sinh method.
#####################################################################
require 'test/helper'
require 'test/unit'

class TC_Math_Sinh_SingletonMethod < Test::Unit::TestCase
  test "sinh basic functionality" do
    assert_respond_to(Math, :sinh)
    assert_nothing_raised{ Math.sinh(1) }
    assert_nothing_raised{ Math.sinh(100) }
    assert_kind_of(Float, Math.sinh(1))
  end

  test "sinh with positive integer argument" do
    assert_nothing_raised{ Math.sinh(1) }
    assert_in_delta(1.175, Math.sinh(1), 0.01)
  end

  test "sinh with zero argument" do
    assert_nothing_raised{ Math.sinh(0) }
    assert_in_delta(0.0, Math.sinh(0), 0.01)
  end

  test "sinh with negative integer argument" do
    assert_nothing_raised{ Math.sinh(-1) }
    assert_in_delta(-1.175, Math.sinh(-1), 0.01)
  end

  test "sinh with positive float argument" do
    assert_nothing_raised{ Math.sinh(0.345) }
    assert_in_delta(0.351, Math.sinh(0.345), 0.01)
  end

  test "sinh with negative float argument" do
    assert_nothing_raised{ Math.sinh(-0.345) }
    assert_in_delta(-0.351, Math.sinh(-0.345), 0.01)
  end

  test "sinh requires a numeric argument" do
    assert_raises(TypeError){ Math.sinh(nil) }
    assert_raises(TypeError){ Math.sinh('test') }
  end

  test "sinh accepts one argument only" do
    assert_raise(ArgumentError){ Math.sinh }
    assert_raise(ArgumentError){ Math.sinh(1,1) }
  end
end
