#####################################################################
# test_acosh.rb
#
# Test cases for the Math.acosh method.
#####################################################################
require 'test/helper'
require 'test/unit'

class TC_Math_Acosh_SingletonMethod < Test::Unit::TestCase
  test "acosh basic functionality" do
    assert_respond_to(Math, :acosh)
    assert_nothing_raised{ Math.acosh(1) }
    assert_kind_of(Float, Math.acosh(1))
  end

  test "acosh with integer argument returns expected value" do
    assert_equal(0.0, Math.acosh(1))
    assert_in_delta(1.31, Math.acosh(2), 0.01)
    assert_in_delta(5.28, Math.acosh(99), 0.01)
  end

  test "acosh raises error is argument is invalid" do
    assert_raises(Math::DomainError){ Math.acosh(0) }
    assert_raises(Math::DomainError){ Math.acosh(-1) }
  end

  test "argument to acosh must be numeric" do
    assert_raise(TypeError){ Math.acosh('test') }
  end

  test "acosh requires one argument only" do
    assert_raise(ArgumentError){ Math.acosh }
    assert_raise(ArgumentError){ Math.acosh(1,2) }
  end
end
