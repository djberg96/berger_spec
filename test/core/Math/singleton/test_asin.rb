#####################################################################
# test_asin.rb
#
# Test cases for the Math.asin method.
#####################################################################
require 'test/helper'
require 'test/unit'

class TC_Math_Asin_Class < Test::Unit::TestCase
  test "asin basic functionality" do
    assert_respond_to(Math, :asin)
    assert_nothing_raised{ Math.asin(1) }
    assert_kind_of(Float, Math.asin(1))
  end

  test "asin with positive integer argument returns expected values" do
    assert_nothing_raised{ Math.asin(1) }
    assert_in_delta(1.57, Math.asin(1), 0.01)
  end

  test "asin with zero argument returns expected values" do
    assert_nothing_raised{ Math.asin(0) }
    assert_equal(0.0, Math.asin(0))
  end

  test "asin with negative integer argument returns expected values" do
    assert_nothing_raised{ Math.asin(-1) }
    assert_in_delta(-1.57, Math.asin(-1), 0.01)
  end

  test "asin with positive float argument returns expected values" do
    assert_nothing_raised{ Math.asin(0.345) }
    assert_in_delta(0.35, Math.asin(0.345), 0.01)
  end

  test "asin with negative float argument returns expected values" do
    assert_nothing_raised{ Math.asin(-0.345) }
    assert_in_delta(-0.35, Math.asin(-0.345), 0.01)
  end

  test "asin raises an error if the argument is invalid" do
    assert_raises(Math::DomainError){ Math.asin(2) }
    assert_raises(Math::DomainError){ Math.asin(-2) }
  end

  test "asin requires a numeric argument" do
    assert_raises(TypeError){ Math.asin('test') }
  end

  test "asin requires one argument only" do
    assert_raises(ArgumentError){ Math.asin }
    assert_raises(ArgumentError){ Math.asin(1, 1) }
  end
end
