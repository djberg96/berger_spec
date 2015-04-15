#####################################################################
# test_exp.rb
#
# Test cases for the Math.exp method.
#####################################################################
require 'test/helper'
require 'test/unit'

class TC_Math_Exp_SingletonMethod < Test::Unit::TestCase
  test "exp basic functionality" do
    assert_respond_to(Math, :exp)
    assert_nothing_raised{ Math.exp(1) }
    assert_nothing_raised{ Math.exp(100) }
    assert_kind_of(Float, Math.exp(1))
  end

  test "exp with positive integer argument" do
    assert_nothing_raised{ Math.exp(1) }
    assert_in_delta(2.71, Math.exp(1), 0.01)
  end

  test "exp with zero argument" do
    assert_nothing_raised{ Math.exp(0) }
    assert_in_delta(1.0, Math.exp(0), 0.01)
  end

  test "exp with negative integer argument" do
    assert_nothing_raised{ Math.exp(-1) }
    assert_in_delta(0.36, Math.exp(-1), 0.01)
  end

  test "exp with positive float argument" do
    assert_nothing_raised{ Math.exp(0.345) }
    assert_in_delta(1.41, Math.exp(0.345), 0.01)
  end

  test "exp with negative float argument" do
    assert_nothing_raised{ Math.exp(-0.345) }
    assert_in_delta(0.70, Math.exp(-0.345), 0.01)
  end

  test "exp requires a numeric argument" do
    assert_raise(TypeError){ Math.exp(nil) }
    assert_raise(TypeError){ Math.exp('test') }
  end

  test "exp requires one argument only" do
    assert_raise(ArgumentError){ Math.exp }
    assert_raise(ArgumentError){ Math.exp(1,1) }
  end
end
