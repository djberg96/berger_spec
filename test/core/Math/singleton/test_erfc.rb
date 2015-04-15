#####################################################################
# test_erfc.rb
#
# Test cases for the Math.erfc method.
#####################################################################
require 'test/helper'
require 'test/unit'

class TC_Math_Erfc_Class < Test::Unit::TestCase
  test "erfc basic functionality" do
    assert_respond_to(Math, :erfc)
    assert_nothing_raised{ Math.erfc(1) }
    assert_kind_of(Float, Math.erfc(1))
  end

  test "erfc with positive integer argument" do
    assert_nothing_raised{ Math.erfc(1) }
    assert_in_delta(0.157, Math.erfc(1), 0.01)
  end

  test "erfc with zero argument" do
    assert_nothing_raised{ Math.erfc(0) }
    assert_in_delta(1.0, Math.erfc(0), 0.01)
  end

  test "erfc with negative integer argument" do
    assert_nothing_raised{ Math.erfc(-1) }
    assert_in_delta(1.84, Math.erfc(-1), 0.01)
  end

  test "erfc with positive float argument" do
    assert_nothing_raised{ Math.erfc(0.345) }
    assert_in_delta(0.625, Math.erfc(0.345), 0.01)
  end

  test "erfc with negative float argument" do
    assert_nothing_raised{ Math.erfc(-0.345) }
    assert_in_delta(1.37, Math.erfc(-0.345), 0.01)
  end

  test "erfc requires a numeric argument" do
    assert_raises(TypeError){ Math.erfc(nil) }
    assert_raises(TypeError){ Math.erfc('test') }
  end

  test "erfc takes one argument only" do
    assert_raises(ArgumentError){ Math.erfc }
    assert_raises(ArgumentError){ Math.erfc(1,1) }
  end
end
