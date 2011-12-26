################################################################
# test_shift.rb
#
# Test suite for the Array#shift instance method.
################################################################
require 'test/helper'
require 'test/unit'

class Test_Array_Shift_InstanceMethod < Test::Unit::TestCase
  def setup
    @array = %w[a b c]
  end

  test "shift basic functionality" do
    assert_respond_to(@array, :shift)
    assert_nothing_raised{ @array.shift }
  end

  test "shift returns expected result" do
    assert_equal('a', @array.shift)
    assert_equal('b', @array.shift)
    assert_equal('c', @array.shift)
  end

  test "shift modifies receiver" do
    assert_nothing_raised{ @array.shift }
    assert_equal(['b', 'c'], @array)
  end

  test "shift returns nil for an empty array" do
    assert_nil([].shift)
  end

  test "shift handles nested arrays as expected" do
    assert_equal(['a'], [['a'], ['b']].shift)
    assert_equal([], [[],[]].shift)
  end

  test "shift handles explicit nil as expected" do
    assert_equal(nil, [nil].shift)
  end

  test "shift handles explicit zero as expected" do
    assert_equal(0, [0].shift)
  end

  test "shift handles explicit false as expected" do
    assert_equal(false, [false].shift)
  end

  test "shift handles explicit true as expected" do
    assert_equal(true, [true].shift)
  end

  test "an error is raised if the wrong number of arguments are passed" do
    assert_raise(ArgumentError){ @array.shift(2, 2) }
  end

  test "an error is raised if an invalid type is used as an argument" do
    assert_raise(TypeError){ @array.shift("foo") }
  end

  def teardown
    @array = nil
  end
end
