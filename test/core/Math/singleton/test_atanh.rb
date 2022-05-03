#####################################################################
# test_atanh.rb
#
# Test cases for the Math.atanh method.
#####################################################################
require 'test/unit'
require 'test/helper'

class TC_Math_Atanh_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  test "atanh basic functionality" do
    assert_respond_to(Math, :atanh)
    assert_nothing_raised{ Math.atanh(0.5) }
    assert_kind_of(Float, Math.atanh(0.5))
  end

  test "atanh with zero argument" do
    assert_nothing_raised{ Math.atanh(0) }
    assert_equal(0.0, Math.atanh(0))
  end

  test "atanh with positive float argument" do
    assert_nothing_raised{ Math.atanh(0.345) }
    assert_in_delta(0.359, Math.atanh(0.345), 0.01)
  end

  test "atanh with negative float argument" do
    assert_nothing_raised{ Math.atanh(-0.345) }
    assert_in_delta(-0.359, Math.atanh(-0.345), 0.01)
  end

  # This is arguably a platform bug. See ruby-core:10174.
  test "atanh edge cases" do
    if WINDOWS || OSX || TRUFFLE
      assert_nothing_raised{ Math.atanh(1) }
      assert_nothing_raised{ Math.atanh(-1) }
      assert_equal(1, Math.atanh(1).infinite?)
      assert_equal(-1, Math.atanh(-1).infinite?)
    else
      assert_raises(Errno::ERANGE, Errno::EDOM){ Math.atanh(1) }
      assert_raises(Errno::ERANGE, Errno::EDOM){ Math.atanh(-1) }
    end
  end

  test "atanh with invalid numeric argument raises an error" do
    assert_raises(Math::DomainError){ Math.atanh(2) }
    assert_raises(Math::DomainError){ Math.atanh(-2) }
  end

  test "atanh requires a numeric argument" do
    assert_raise(TypeError){ Math.atanh('test') }
  end

  test "atanh takes a single argument only" do
    assert_raise(ArgumentError){ Math.atanh }
    assert_raise(ArgumentError){ Math.atanh(1,1) }
  end
end
