#####################################################################
# test_cosh.rb
#
# Test cases for the Math.cosh method.
#####################################################################
require 'test/helper'
require 'test/unit'

class TC_Math_Cosh_Singleton < Test::Unit::TestCase
  test "cosh basic functionality" do
    assert_respond_to(Math, :cosh)
    assert_nothing_raised{ Math.cosh(1) }
    assert_nothing_raised{ Math.cosh(100) }
    assert_kind_of(Float, Math.cosh(1))
  end

  test "cosh with positive integer argument" do
    assert_nothing_raised{ Math.cosh(1) }
    assert_in_delta(1.54, Math.cosh(1), 0.01)
  end

  test "cosh with zero argument" do
    assert_nothing_raised{ Math.cosh(0) }
    assert_in_delta(1.0, Math.cosh(0), 0.01)
  end

  test "cosh with negative argument" do
    assert_nothing_raised{ Math.cosh(-1) }
    assert_in_delta(1.54, Math.cosh(-1), 0.01)
  end

  test "cosh with positive float argument" do
    assert_nothing_raised{ Math.cosh(0.345) }
    assert_in_delta(1.06, Math.cosh(0.345), 0.01)
  end

  test "cosh with negative float argument" do
    assert_nothing_raised{ Math.cosh(-0.345) }
    assert_in_delta(1.06, Math.cosh(-0.345), 0.01)
  end

  test "cosh requires a numeric argument" do
    assert_raises(TypeError){ Math.cosh(nil) }
    assert_raises(TypeError){ Math.cosh('test') }
  end

  test "cosh takes one argument only" do
    assert_raises(ArgumentError){ Math.cosh }
    assert_raises(ArgumentError){ Math.cosh(1,1) }
  end
end
