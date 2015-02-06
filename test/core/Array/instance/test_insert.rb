#######################################################################
# test_insert.rb
#
# Test case for the Array#insert instance method.
#######################################################################
require 'test/helper'
require 'test/unit'

class Test_Array_Insert_InstanceMethod < Test::Unit::TestCase
  def setup
    @array = ['a', 'b', 'c']
  end

  test "insert basic functionality" do
    assert_respond_to(@array, :insert)
    assert_nothing_raised{ @array.insert(1, 1) }
    assert_kind_of(Array, @array.insert(1, 1))
  end

  test "insert with one value works as expected" do
    assert_equal(['a', 'b', 7, 'c'], @array.insert(2, 7))
  end

  test "insert with multiple values works as expected" do
    assert_equal(['a','b', 7, 8, 9, 'c'], @array.insert(2, 7, 8, 9))
  end

  test "insert with a negative index works as expected" do
    assert_equal(['a', 'b', 7, 8, 9, 'c'], @array.insert(-2, 7, 8, 9))
  end

  test "an index of negative one effectively concatenates the array" do
    assert_equal(['a','b','c', 7, 8, 9], @array.insert(-1, 7, 8, 9))
  end

  test "nil is filled in if the index is out of bounds" do
    assert_equal(['a','b','c', nil, nil, 7], @array.insert(5, 7))
  end

  test "a float index is treated as an integer" do
    assert_equal(['a', 'b', 7, 'c'], @array.insert(2.5, 7))
    assert_equal(['z', 'a', 'b', 7, 'c'], @array.insert(0.0, 'z'))
  end

  test "using an index on a recursive array works as expected" do
    @array = @array << @array
    assert_nothing_raised{ @array.insert(3, 'test') }
    assert_nothing_raised{ @array.insert(9, 'test') }
  end

  test "an error is raised if no index is provided" do
    assert_raise(ArgumentError){ @array.insert }
  end

  test "providing an index with no values is effectively a no-op" do
    assert_equal(@array, @array.insert(0))
  end

  test "an error is raised if the index is out of bounds on the left side" do
    assert_raise(IndexError){ @array.insert(-9, 7) }
  end

  def teardown
    @array = nil
  end
end
