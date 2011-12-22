##########################################################################
# test_flatten.rb
#
# Test suite for the Array#flatten instance method. Tests for the
# Array#flatten! instance method are in the test_flatten_bang.rb file.
##########################################################################
require 'test/unit'

class Test_Array_Flatten_InstanceMethod < Test::Unit::TestCase
  def setup
    @array = [1, [2, 3, [4,5]]]
  end

  test "flatten basic functionality" do
    assert_respond_to(@array, :flatten)
    assert_nothing_raised{ @array.flatten }
    assert_kind_of(Array, @array.flatten)
  end

  test "flatten expected results" do
    assert_equal([1,2,3,4,5], @array.flatten)
    assert_equal([1,2,3], [1,2,3].flatten)
  end

  test "flatten does not modify the original receiver" do
    assert_nothing_raised{ @array.flatten }
    assert_equal([1,[2,3,[4,5]]], @array)
  end

  test "flatten returns an empty array if called on an empty array" do
    assert_equal([], [].flatten)
  end

  test "flatten handles explicit nils as expected" do
    assert_equal([nil], [nil].flatten)
  end

  test "flatten handles nested empty arrays as expected" do
    assert_equal([], [[],[],[]].flatten)
    assert_equal([], [[[[[[]]]]]].flatten)
  end

  test "attempting to flatten a recursive array raises an error" do
    array = @array << @array
    assert_raise(ArgumentError){ array.flatten }
  end

  test "attempting to flatten a recursive array emits a specific error message" do
    @array = @array << @array
    assert_raise_message("tried to flatten recursive array"){ @array.flatten }
  end

  test "flatten raises an error if the wrong number of arguments are passed" do
    assert_raise(ArgumentError){ @array.flatten(1) }
  end

  def teardown
    @array = nil
  end
end
