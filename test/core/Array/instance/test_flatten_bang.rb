##########################################################################
# test_flatten.rb
#
# Test suite for the Array#flatten instance method. Tests for the
# Array#flatten! instance method are in the test_flatten_bang.rb file.
##########################################################################
require 'test/unit'

class Test_Array_FlattenBang_InstanceMethod < Test::Unit::TestCase
  def setup
    @array = [1, [2, 3, [4,5]]]
  end

  test "flatten bang basic functionality" do
    assert_respond_to(@array, :flatten!)
    assert_nothing_raised{ @array.flatten! }
    assert_kind_of(Array, [1, [2, 3]].flatten!)
  end

  test "flatten bang returns array if flattening occurs" do
    assert_equal([1,2,3,4,5], @array.flatten!)
  end

  test "flatten bang returns nil if no flattening occurs" do
    assert_nil([1,2,3].flatten!)
  end

  test "flatten bang modifies the original receiver" do
    assert_nothing_raised{ @array.flatten! }
    assert_equal([1,2,3,4,5], @array)
  end

  test "flatten bang handles empty arrays as expected" do
    assert_nil([].flatten!)
    assert_equal([], [[],[],[]].flatten!)
    assert_equal([], [[[[[[]]]]]].flatten!)
  end

  test "flatten bang handles explicit nils as expected" do
    assert_nil([nil].flatten!)
    assert_equal([nil], [[nil]].flatten!)
  end

  test "an error is raised if the wrong number of arguments are passed" do
    assert_raise(ArgumentError){ @array.flatten!(1) }
  end

  test "attempting to flatten a recursive array raises an error" do
    @array = @array << @array
    assert_raise(ArgumentError){ @array.flatten! }
  end

  test "attempting to flatten a recursive array emits a specific error message" do
    @array = @array << @array
    assert_raise_message("tried to flatten recursive array"){ @array.flatten! }
  end

  def teardown
    @array = nil
  end
end
