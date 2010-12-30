###############################################################################
# tc_quo.rb
#
# Test case for the Bignum#quo instance method. These tests are problematic
# because they are platform/architecture/bit specific. I would prefer to use
# the rational library, but that messes up other tests.
###############################################################################
require 'test/helper'
require 'test/unit'

class TC_Bignum_Quo_InstanceMethod < Test::Unit::TestCase
  def setup
    @bignum_pos  = 18446744073709551616
    @bignum_neg  = -18446744073709551616
    @bignum_posf = 18446744073709551616.34
    @bignum_negf = -18446744073709551616.97
  end

  test "quo basic functionality" do
    assert_respond_to(@bignum_pos, :quo)
    assert_nothing_raised{ @bignum_pos.quo(1) }
  end

  test "quo with an integer argument returns the expected results" do
    assert_in_delta('1.34343777392102e+15', @bignum_pos.quo(13731), 2)
    assert_in_delta('-1.34343777392102e+15', @bignum_neg.quo(13731), 2)
    assert_in_delta('1.34343777392102e+15', @bignum_pos.quo(13731), 2)
    assert_in_delta('-1.34343777392102e+15', @bignum_neg.quo(13731), 2)
  end

  test "quo with a float argument returns the expected results" do
    assert_in_delta('1.34341429278853e+15', @bignum_pos.quo(13731.24), 1.75)
    assert_in_delta('-1.34341429278853e+15', @bignum_neg.quo(13731.24), 1.75)
    assert_in_delta('1.34341429278853e+15', @bignum_pos.quo(13731.24), 1.75)
    assert_in_delta('-1.34341429278853e+15', @bignum_neg.quo(13731.24), 1.75)
  end

  test "quo with an argument of 1 returns itself" do
    assert_equal(@bignum_pos, @bignum_pos.quo(1))
    assert_equal(@bignum_neg, @bignum_neg.quo(1.0))
  end

  test "quo only accepts one argument" do
    assert_raise(ArgumentError){ @bignum_pos.quo(1, 2) }
  end

  test "quo with an argument of zero raises an error" do
    assert_raise(ZeroDivisionError){ @bignum_pos.quo(0) }
  end

  test "the argument to quot must be numeric" do
    assert_raise(TypeError){ @bignum_pos.quo('test') }
  end

  def teardown
    @bignum_pos  = nil
    @bignum_neg  = nil
    @bignum_posf = nil
    @bignum_negf = nil
  end
end
