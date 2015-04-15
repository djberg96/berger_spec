#####################################################################
# test_log10.rb
#
# Test cases for the Math.log10 method.
#####################################################################
require 'test/helper'
require 'test/unit'

class TC_Math_Log10_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  test "log10 basic functionality" do
    assert_respond_to(Math, :log10)
    assert_nothing_raised{ Math.log10(1) }
    assert_nothing_raised{ Math.log10(100) }
    assert_kind_of(Float, Math.log10(1))
  end

  test "log10 with positive integer argument" do
    assert_nothing_raised{ Math.log10(1) }
    assert_in_delta(0.0, Math.log10(1), 0.01)
  end

  test "log10 with positive float argument" do
    assert_nothing_raised{ Math.log10(0.345) }
    assert_in_delta(-0.46, Math.log10(0.345), 0.01)
  end

  test "log10 returns Infinity" do
    omit_unless(OSX || JRUBY)
    assert_equal('-Infinity', Math.log10(0).to_s)
  end

  test "log10 with invalid argument raises an error" do
    omit_unless(OSX || JRUBY)
    assert_raises(Errno::ERANGE){ Math.log10(0) }
    assert_raises(Errno::EDOM){ Math.log10(-1) }
  end

  test "argument to log10 must be numeric" do
    assert_raises(TypeError){ Math.log10(nil) }
    assert_raises(TypeError){ Math.log10('test') }
  end

  test "log10 accepts one argument only" do
    assert_raise(ArgumentError){ Math.log10 }
    assert_raise(ArgumentError){ Math.log10(1,1) }
  end
end
