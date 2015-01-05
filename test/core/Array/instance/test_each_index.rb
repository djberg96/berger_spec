###########################################################
# test_each_index.rb
#
# Test suite for the Array#each_index instance method.
###########################################################
require 'test/helper'
require 'test/unit'

class Test_Array_EachIndex_InstanceMethod < Test::Unit::TestCase
  def setup
    @count = 0
    @array = %w/ant bat cat dog/
  end

  test "each_index basic functionality" do
    assert_respond_to(@array, :each_index)
    assert_nothing_raised{ @array.each_index{} }
  end

  test "each_index iterates as expected" do
    @array.each_index{ |index|
      assert_equal(@count, index)
      @count += 1
    }
    assert_equal(4, @count)
  end

  test "each_index returns an array" do
    @array = [1, 2, 3]
    assert_equal([1, 3, 3], @array.each_index{ |i| @array[i] += 1 if i % 2 != 0 })
  end

  test "an error is not raised if the receiver is modified during iteration" do
    assert_nothing_raised{ @array.each_index{ |i| @array.pop } }
  end

  test "each_index without block argument returns original array" do
    assert_equal(@array, @array.each_index{})
  end

  test "each_index returns an enumerator object if no block is provided" do
    assert_kind_of(Enumerator, @array.each_index)
  end

  test "an error is raised if the wrong number of arguments are passed" do
    assert_raise(ArgumentError){ @array.each_index(1){} }
  end

  def teardown
    @count = nil
    @array = nil
  end
end
