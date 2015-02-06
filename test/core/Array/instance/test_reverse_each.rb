###########################################################
# test_reverse_each.rb
#
# Test suite for the Array#reverse_each instance method.
###########################################################
require 'test/helper'
require "test/unit"

class Test_Array_ReverseEach_InstanceMethod < Test::Unit::TestCase
  def setup
    @array = ['ant', 'bat', 'cat', 'dog']
  end

  test "reverse_each basic functionality" do
    assert_respond_to(@array, :reverse_each)
    assert_nothing_raised{ @array.reverse_each{} }
    assert_kind_of(Array, @array.reverse_each{})
  end

  test "reverse_each iterates as expected" do
    i = 3
    @array.reverse_each{ |e|
      assert_equal(@array[i], e)
      i -= 1
    }
    assert_equal(-1, i)
  end

  test "reverse_each does not modify the receiver" do
    assert_nothing_raised{ @array.reverse_each{} }
    assert_equal(['ant', 'bat', 'cat', 'dog'], @array)
  end

  test "reverse_each on an empty array is effectively a no-op" do
    i = 0
    [].reverse_each{ i += 1 }
    assert_equal(0, i)
    assert_equal(@array, @array.reverse_each{})
  end

  test "reverse_each handles recursive arrays properly" do
    @array = @array << @array
    temp = []
    assert_nothing_raised{ @array.reverse_each{ |e| temp << e } }
    assert_equal(5, temp.size)
  end

  test "reverse_each without a block returns an Enumerator object" do
    assert_kind_of(Enumerator, @array.reverse_each)
  end

  test "reverse_each with the wrong number of arguments raises an error" do
    assert_raise(ArgumentError){ @array.reverse_each(1){} }
  end

  def teardown
    @array = nil
  end
end
