############################################################
# test_append.rb
#
# Test suite for the Array#<< instance method.
############################################################
require 'test/helper'
require 'test/unit'

class Test_Array_Append_InstanceMethod < Test::Unit::TestCase
  def setup
    @array1 = [1,2,3]
    @array2 = ['hello', 'world']
    @nested = [[1,2], ['hello','world']]
  end

  test "append basic functionality" do
    assert_respond_to(@array1, :<<)
    assert_nothing_raised{ @array1 << 4 }
    assert_kind_of(Array, @array1 << 4)
  end 

  test "appending to an array modifies the receiver" do
    assert_nothing_raised{ @array1 << 4 }
    assert_equal([1, 2, 3, 4], @array1)
  end

  test "appending an array results in a nested array" do
    assert_nothing_raised{ @array1 << [4, 5] }
    assert_equal([1, 2, 3, [4, 5]], @array1)
  end

  test "appending to a nested array works as expected" do
    assert_equal([[1,2], ['hello','world'], 3], @nested << 3)
  end

  test "append chaining works as expected" do
    assert_nothing_raised{ @array1 << 4 << "test" << 7.7 }
    assert_equal([1, 2, 3, 4, "test", 7.7], @array1)
  end

  test "append returns original array instead of a copy" do
    assert_true((@array1 << 4).object_id == @array1.object_id)
    assert_equal([1, 2, 3, 4], @array1)
  end

  test "appending an explicit nil works as expected" do
    assert_equal(["hello", "world", nil], @array2 << nil)
  end

  test "appending a boolean value works as expected" do
    assert_equal(["hello", "world", false], @array2 << false)
    assert_equal(["hello", "world", false, true], @array2 << true)
  end

  test "sending the wrong number of arguments raises an error" do
    assert_raise(ArgumentError){ @array1.send(:<<) }
    assert_raise(ArgumentError){ @array1.send(:<<, 1, 2) }
  end

  def teardown
    @array1 = nil
    @array2 = nil
    @nested = nil
  end
end
