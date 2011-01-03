########################################################################
# test_values_at.rb
#
# Test suite for the Array#values_at instance method.
########################################################################
require 'test/helper'
require 'test/unit'

class Test_Array_ValuesAt_InstanceMethod < Test::Unit::TestCase
  def setup
    @array  = %w/a b c d e f/
    @nested = [[1,2], 3, ['a', 'b','c']]
  end

  test "values_at basic functionality" do
    assert_respond_to(@array, :values_at)
    assert_nothing_raised{ @array.values_at }
  end

  test "values_at with no arguments returns an empty array" do
    assert_equal([], @array.values_at)
  end

  test "values_at with a single argument returns expected result" do
    assert_equal(['a'], @array.values_at(0))
    assert_equal([nil], @array.values_at(99))
  end

  test "values_at with multiple arguments return expected result" do
    assert_equal(['b', 'd', 'f'], @array.values_at(1, 3, 5))
    assert_equal(['b', nil, 'f'], @array.values_at(1, 99, 5))
  end

  test "values_at with float arguments works as expected" do
    assert_equal(['b', 'd', 'f'], @array.values_at(1.0, 3.0, 5.0))
    assert_equal(['b', nil, 'f'], @array.values_at(1.3, 127.9, 5.9))
  end

  test "values_at with negative integer arguments works as expected" do
    assert_equal(['f', 'd'], @array.values_at(-1, -3))
    assert_equal(['f', nil ,nil], @array.values_at(-1, -7, -9))
  end

  test "values_at with a range argument works as expected" do
    assert_equal(['a', 'b', 'c'], @array.values_at(0..2))
    assert_equal(['a', 'b', 'c', 'c', 'd', 'e'], @array.values_at(0..2, 2..4))
  end
   
  test "values_at handles nested arrays properly" do
    assert_equal([[1,2]], @nested.values_at(0))
    assert_equal([['a', 'b', 'c'], 3, [1,2]], @nested.values_at(2, 1, 0))
    assert_equal([[1,2], 3, ['a', 'b','c']], @nested.values_at(0..2))
    assert_equal([[1,2], 3, ['a', 'b','c'], nil], @nested.values_at(0..3))
  end
   
  test "values_at on array with explicit nil value works as expected" do
    assert_equal([nil], [nil].values_at(0))
  end

  test "values_at on array with explicit true value works as expected" do
    assert_equal([true], [true].values_at(0))
  end

  test "values_at on array with explicit false value works as expected" do
    assert_equal([false], [false].values_at(0))
  end

  test "values_at on array with explicit zero value works as expected" do
    assert_equal([0], [0, 0, 0].values_at(0))
  end

  test "passing the wrong type of argument raises an error" do
    assert_raise(TypeError){ @array.values_at(nil) }
    assert_raise(TypeError){ @array.values_at([]) }
    assert_raise(TypeError){ @array.values_at("foo") }
    assert_raise(TypeError){ @array.values_at(true) }
  end

  def teardown
    @array  = nil
    @nested = nil
  end
end
