#####################################################################
# test_log.rb
#
# Test cases for the Math.log method.
#####################################################################
require 'test/helper'
require 'test/unit'

class TC_Math_Log_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  test "log basic functionality" do
    assert_respond_to(Math, :log)
    assert_nothing_raised{ Math.log(1) }
    assert_nothing_raised{ Math.log(100) }
    assert_kind_of(Float, Math.log(1))
  end

  test "log with positive integer argument" do
    assert_nothing_raised{ Math.log(1) }
    assert_in_delta(0.0, Math.log(1), 0.01)
  end

  test "log with positive integer argument and base" do
    assert_nothing_raised{ Math.log(12, 8) }
    assert_in_delta(1.1949, Math.log(12, 8), 0.01)
  end

  test "log with positive float argument" do
    assert_nothing_raised{ Math.log(0.345) }
    assert_in_delta(-1.06, Math.log(0.345), 0.01)
  end

  test "log with positive float argument and base" do
    assert_nothing_raised{ Math.log(12.0, 8) }
    assert_in_delta(1.1949, Math.log(12.0, 8), 0.01)
  end

  test "log with zero argument returns infinity" do
    assert_equal('-Infinity', Math.log(0).to_s)
  end

  test "invalid argument to log raises an error" do
    assert_raises(Math::DomainError){ Math.log(-1) }
  end

  test "argument to log must be numeric" do
    assert_raises(TypeError){ Math.log(nil) }
    assert_raises(TypeError){ Math.log('test') }
    assert_raises(TypeError){ Math.log(10, nil) }
  end

  test "log takes one or two arguments only" do
    assert_raise(ArgumentError){ Math.log }
    assert_raise(ArgumentError){ Math.log(1,1,1) }
  end
end
