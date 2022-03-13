######################################################################
# test_floor.rb
#
# Test case for the Float#floor instance method.
######################################################################
require 'test/helper'
require 'test/unit'

class Test_Float_Floor_InstanceMethod < Test::Unit::TestCase
  def setup
    @float_pos = 1.07
    @float_neg = -0.93
  end

  test "floor basic functionality" do
    assert_respond_to(@float_pos, :floor)
    assert_nothing_raised{ @float_pos.floor }
    assert_kind_of(Integer, @float_pos.floor)
  end

  test "floor with no arguments returns expected value for postive floats" do
    assert_equal(1, @float_pos.floor)
    assert_equal(1, (1.0).floor)
    assert_equal(0, (0.0).floor)
  end

  test "floor with no arguments returns expected value for negative floats" do
    assert_equal(-1, @float_neg.floor)
  end

  test "floor with arguments returns the expected value" do
    assert_equal(0.5, 0.555.floor(1))
    assert_equal(0.55, 0.555.floor(2))
    assert_equal(0.555, 0.555.floor(3))
    assert_equal(0.555, 0.555.floor(99))
  end

  test "arguments to floor must be numeric" do
    assert_raise(TypeError){ 0.555.floor("test") }
    assert_raise(TypeError){ 0.555.floor(true) }
    assert_raise(TypeError){ 0.555.floor(false) }
    assert_raise(TypeError){ 0.555.floor(nil) }
  end

  def teardown
    @float_pos = nil
    @float_neg = nil
  end
end
