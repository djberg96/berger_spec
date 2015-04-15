#####################################################################
# test_frexp.rb
#
# Test cases for the Math.frexp method.
#####################################################################
require 'test/helper'
require 'test/unit'

class TC_Math_Frexp_SingletonMethod < Test::Unit::TestCase
  test "frexp basic functionality" do
    assert_respond_to(Math, :frexp)
    assert_nothing_raised{ Math.frexp(1) }
    assert_nothing_raised{ Math.frexp(-100) }
    assert_kind_of(Array, Math.frexp(1234))
  end

  test "frexp with positive integer argument" do
    assert_nothing_raised{ Math.frexp(1) }
    assert_in_delta(0.602, Math.frexp(1234).first, 0.01)
    assert_equal(11, Math.frexp(1234).last)
  end

  test "frexp with zero argument" do
    assert_nothing_raised{ Math.frexp(0) }
    assert_in_delta(0.0, Math.frexp(0).first, 0.01)
    assert_equal(0, Math.frexp(0).last)
  end

  test "frexp with negative integer argument" do
    assert_nothing_raised{ Math.frexp(-1) }
    assert_in_delta(-0.5, Math.frexp(-1).first, 0.01)
    assert_equal(1, Math.frexp(-1).last) # TODO: check
  end

  test "frexp with positive float argument" do
    assert_nothing_raised{ Math.frexp(0.345) }
    assert_in_delta(0.69, Math.frexp(0.345).first, 0.01)
    assert_equal(-1, Math.frexp(0.345).last) # TODO: check
  end

  test "frexp with negative float argument" do
    assert_nothing_raised{ Math.frexp(-0.345) }
    assert_in_delta(-0.69, Math.frexp(-0.345).first, 0.01)
    assert_equal(-1, Math.frexp(-0.345).last) # TODO: check
  end

  test "argument to frexp must be numeric" do
    assert_raise(TypeError){ Math.frexp(nil) }
    assert_raise(TypeError){ Math.frexp('test') }
  end

  test "frexp takes a single argument only" do
    assert_raise(ArgumentError){ Math.frexp }
    assert_raise(ArgumentError){ Math.frexp(1,1) }
  end
end
