######################################################################
# test_ceil.rb
#
# Test case for the Float#ceil instance method.
######################################################################
require 'test/helper'
require 'test/unit'

class Test_Float_Ceil_InstanceMethod < Test::Unit::TestCase
  def setup
    @float_pos = 1.07
    @float_neg = -0.93
  end

  test "ceil basic functionality" do
    assert_respond_to(@float_pos, :ceil)
    assert_nothing_raised{ @float_pos.ceil }
    assert_kind_of(Integer, @float_pos.ceil)
  end

  test "ceil with no argument for positive float returns expected value" do
    assert_equal(2, @float_pos.ceil)
    assert_equal(1, (1.0).ceil)
    assert_equal(0, (0.0).ceil)
  end

  test "ceil with no argument for negative float returns expected value" do
    assert_equal(0, @float_neg.ceil)
  end

  test "ceil with arguments returns the expected value" do
    assert_equal(0.6, 0.555.ceil(1))
    assert_equal(0.56, 0.555.ceil(2))
    assert_equal(0.555, 0.555.ceil(3))
    assert_equal(0.555, 0.555.ceil(99))
  end

  test "argument to ceil must be numeric" do
    assert_raise(TypeError){ @float_pos.ceil("test") }
    assert_raise(TypeError){ @float_pos.ceil(true) }
    assert_raise(TypeError){ @float_pos.ceil(false) }
    assert_raise(TypeError){ @float_pos.ceil(nil) }
  end

  test "ceil method only accepts one argument" do
    assert_raise(ArgumentError){ @float_pos.ceil(1,2) }
  end

  def teardown
    @float_pos = nil
    @float_neg = nil
  end
end
