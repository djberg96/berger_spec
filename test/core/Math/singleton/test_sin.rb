#####################################################################
# test_sin.rb
#
# Test cases for the Math.sin method.
#####################################################################
require 'test/helper'
require 'test/unit'

class TC_Math_Sin_Singleton < Test::Unit::TestCase
  test "sin basic functionality" do
    assert_respond_to(Math, :sin)
    assert_nothing_raised{ Math.sin(1) }
    assert_nothing_raised{ Math.sin(100) }
    assert_kind_of(Float, Math.sin(1))
  end

  test "sin with positive integer argument" do
    assert_nothing_raised{ Math.sin(1) }
    assert_in_delta(0.84, Math.sin(1), 0.01)
  end

  test "sin with zero argument" do
    assert_nothing_raised{ Math.sin(0) }
    assert_in_delta(0.0, Math.sin(0), 0.01)
  end

  test "sin with negative integer argument" do
    assert_nothing_raised{ Math.sin(-1) }
    assert_in_delta(-0.84, Math.sin(-1), 0.01)
  end

  test "sin with positive float argument" do
    assert_nothing_raised{ Math.sin(0.345) }
    assert_in_delta(0.338, Math.sin(0.345), 0.01)
  end

  test "sin with negative float argument" do
    assert_nothing_raised{ Math.sin(-0.345) }
    assert_in_delta(-0.338, Math.sin(-0.345), 0.01)
  end

  test "sin requires a numeric argument" do
    assert_raises(TypeError){ Math.sin(nil) }
    assert_raises(TypeError){ Math.sin('test') }
  end

  test "sin takes one argument only" do
    assert_raise(ArgumentError){ Math.sin }
    assert_raise(ArgumentError){ Math.sin(1,1) }
  end
end
