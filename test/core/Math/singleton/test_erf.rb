#####################################################################
# test_erf.rb
#
# Test cases for the Math.erf method.
#####################################################################
require 'test/helper'
require 'test/unit'

class TC_Math_Erf_SingletonMethod < Test::Unit::TestCase
  test "erf basic functionality" do
    assert_respond_to(Math, :erf)
    assert_nothing_raised{ Math.erf(1) }
    assert_kind_of(Float, Math.erf(1))
  end

  test "erf with positive integer argument" do
    assert_nothing_raised{ Math.erf(1) }
    assert_in_delta(0.84, Math.erf(1), 0.01)
  end

  test "erf with zero argument" do
    assert_nothing_raised{ Math.erf(0) }
    assert_in_delta(0.0, Math.erf(0), 0.01)
  end

  test "erf with negative integer argument" do
    assert_nothing_raised{ Math.erf(-1) }
    assert_in_delta(-0.84, Math.erf(-1), 0.01)
  end

  test "erf with positive float argument" do
    assert_nothing_raised{ Math.erf(0.345) }
    assert_in_delta(0.374, Math.erf(0.345), 0.01)
  end

  test "erf with negative float argument" do
    assert_nothing_raised{ Math.erf(-0.345) }
    assert_in_delta(-0.374, Math.erf(-0.345), 0.01)
  end

  test "erf requires a numeric argument" do
    assert_raises(TypeError){ Math.erf(nil) }
    assert_raises(TypeError){ Math.erf('test') }
  end

  test "erf takes a single argument only" do
    assert_raises(ArgumentError){ Math.erf }
    assert_raises(ArgumentError){ Math.erf(1,1) }
  end
end
