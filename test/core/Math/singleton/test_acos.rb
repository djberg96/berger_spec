#####################################################################
# test_acos.rb
#
# Test cases for the Math.acos method.
#####################################################################
require 'test/helper'
require 'test/unit'

class TC_Math_Acos_SingletonMethod < Test::Unit::TestCase
  test "acos basic functionality" do
    assert_respond_to(Math, :acos)
    assert_nothing_raised{ Math.acos(1) }
    assert_kind_of(Float, Math.acos(1))
  end

  test "acos with positive integer argument returns expected results" do
    assert_nothing_raised{ Math.acos(1) }
    assert_equal(0.0, Math.acos(1))
  end

  test "acos with 0 argument returns expected results" do
    assert_nothing_raised{ Math.acos(0) }
    assert_in_delta(1.57, Math.acos(0), 0.01)
  end

  test "acos with negative integer argument returns expected results" do
    assert_nothing_raised{ Math.acos(-1) }
    assert_in_delta(3.14, Math.acos(-1), 0.01)
  end

  test "acos with positive float argument returns expected results" do
    assert_nothing_raised{ Math.acos(0.345) }
    assert_in_delta(1.21, Math.acos(0.345), 0.01)
  end

  test "acos with negative float argument returns expected results" do
    assert_nothing_raised{ Math.acos(-0.345) }
    assert_in_delta(1.92, Math.acos(-0.345), 0.01)
  end

  test "acos with invalid numeric argument raises the expected error" do
    assert_raises(Math::DomainError){ Math.acos(2) }
    assert_raises(Math::DomainError){ Math.acos(-2) }
  end

  test "argument to acos must be numeric" do
    assert_raise(TypeError){ Math.acos('test') }
  end
end
