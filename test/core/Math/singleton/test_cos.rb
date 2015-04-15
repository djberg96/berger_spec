#####################################################################
# test_cos.rb
#
# Test cases for the Math.cos method.
#####################################################################
require 'test/helper'
require 'test/unit'

class TC_Math_Cos_Singleton < Test::Unit::TestCase
  test "cos basic functionality" do
    assert_respond_to(Math, :cos)
    assert_nothing_raised{ Math.cos(1) }
    assert_kind_of(Float, Math.cos(1))
  end

  test "cos with positive integer argument" do
    assert_nothing_raised{ Math.cos(1) }
    assert_in_delta(0.54, Math.cos(1), 0.01)
  end

  test "cos with zero argument" do
    assert_nothing_raised{ Math.cos(0) }
    assert_in_delta(1.0, Math.cos(0), 0.01)
  end

  test "cos with negative integer argument" do
    assert_nothing_raised{ Math.cos(-1) }
    assert_in_delta(0.54, Math.cos(-1), 0.01)
  end

  test "cos with with positive float argument" do
    assert_nothing_raised{ Math.cos(0.345) }
    assert_in_delta(0.94, Math.cos(0.345), 0.01)
  end

  test "cos with negative float argument" do
    assert_nothing_raised{ Math.cos(-0.345) }
    assert_in_delta(0.94, Math.cos(-0.345), 0.01)
  end

  test "argument to cos must be numeric" do
    assert_raises(TypeError){ Math.cos(nil) }
    assert_raises(TypeError){ Math.cos('test') }
  end

  test "cos takes one argument only" do
    assert_raise(ArgumentError){ Math.cos }
    assert_raise(ArgumentError){ Math.cos(1,1) }
  end
end
