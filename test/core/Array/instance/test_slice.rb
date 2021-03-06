#####################################################################
# test_slice.rb
#
# Test suite for the Array#slice instance method.
#####################################################################
require 'test/helper'
require 'test/unit'

class TC_Array_Slice_InstanceMethod < Test::Unit::TestCase
  def setup
    @array = %w/a b c d e/
  end

  test "slice basic functionality" do
    assert_respond_to(@array, :slice)
  end

  test "slice accepts a single integer argument" do
    assert_nothing_raised{ @array.slice(1) }
  end

  test "slice returns a single element if a single integer is provided" do
    assert_equal('a', @array.slice(0))
    assert_equal('e', @array.slice(-1))
  end

  test "slice returns nil if the integer is out of bounds" do
    assert_nil(@array.slice(99))
    assert_nil(@array.slice(-99))
  end

  test "slice accepts a start and a length" do
    assert_nothing_raised{ @array.slice(1, 2) }
  end

  test "slice returns an array of elements if a start and length are provided" do
    assert_kind_of(Array, @array.slice(1, 2))
    assert_equal(['b', 'c'], @array.slice(1, 2))
  end

  test "slice returns nil if the start is out of bounds" do
    assert_nil(@array.slice(99, 2))
  end

  test "slice returns all remaining elements if the length is greater than the array size" do
    assert_equal(['c', 'd', 'e'], @array.slice(2, 99))
  end

  test "slice accepts a range" do
    assert_nothing_raised{ @array.slice(1..2) }
  end

  test "slice returns the expected results for a range within its size and length" do
    assert_equal(['b', 'c'], @array.slice(1..2))
    assert_equal(['c', 'd', 'e'], @array.slice(2..-1))
  end

  test "slice returns nil for a range if its size is greater than the array size" do
    assert_nil(@array.slice(99..101))
  end

  test "slice returns all remaining elements if the range length is greater than the array size" do
    assert_equal(['c', 'd', 'e'], @array.slice(2..99))
  end

  test "slice does not modify its receiver" do
    @array.slice(1, 2)
    assert_equal(%w[a b c d e], @array)
  end

  test "slice accepts a maximum of two arguments" do
    assert_raises(ArgumentError){ @array.slice(1, 2, 3) }
  end

  test "slice accepts integer and range arguments only" do
    assert_raises(TypeError){ @array.slice(true) }
    assert_raises(TypeError){ @array.slice(2, nil) }
    assert_raises(TypeError){ @array.slice(nil, 2) }
  end

  def teardown
    @array = nil
  end
end
