#####################################################################
# test_sqrt.rb
#
# Test cases for the Math.sqrt method.
#####################################################################
require 'test/helper'
require 'test/unit'

class TC_Math_Sqrt_SingletonMethod < Test::Unit::TestCase
  test "sqrt basic functionality" do
    assert_respond_to(Math, :sqrt)
    assert_nothing_raised{ Math.sqrt(1) }
    assert_nothing_raised{ Math.sqrt(100) }
    assert_kind_of(Float, Math.sqrt(1))
  end

  test "sqrt with positive integer" do
    assert_nothing_raised{ Math.sqrt(1) }
    assert_in_delta(1.0, Math.sqrt(1), 0.01)
  end

  test "sqrt with zero argument" do
    assert_nothing_raised{ Math.sqrt(0) }
    assert_in_delta(0.0, Math.sqrt(0), 0.01)
  end

  test "sqrt with positive float argument" do
    assert_nothing_raised{ Math.sqrt(0.345) }
    assert_in_delta(0.58, Math.sqrt(0.345), 0.01)
  end

  test "sqrt with invalid argument raises an error" do
    assert_raises(Math::DomainError){ Math.sqrt(-1) }
  end

  test "sqrt requires a numeric argument" do
    assert_raises(TypeError){ Math.sqrt(nil) }
    assert_raises(TypeError){ Math.sqrt('test') }
  end

  test "sqrt takes a single argument only" do
    assert_raise(ArgumentError){ Math.sqrt }
    assert_raise(ArgumentError){ Math.sqrt(4,4) }
  end
end
