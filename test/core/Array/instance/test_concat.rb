###############################################################################
# test_concat.rb
#
# Test suite for the Array#concat instance method. I've added a class with
# a custom to_ary method to ensure that it behaves properly with Array#concat.
###############################################################################
require "test/unit"

class Test_Array_Concat_InstanceMethod < Test::Unit::TestCase
  class AConcat
    def to_ary
      ['a', 'b', 'c']
    end
  end

  def setup
    @array1 = [1,2,3]
    @array2 = [4,5,6]
    @custom = AConcat.new
  end

  test "concat basic functionality" do
    assert_respond_to(@array1, :concat)
    assert_nothing_raised{ @array1.concat(@array2) }
    assert_kind_of(Array, @array1.concat(@array2))
  end

  test "concat expected results" do
    assert_equal([1, 2, 3, 4, 5, 6], @array1.concat(@array2))
  end

  test "concat honors to_ary in custom objects" do
    assert_equal([1, 2, 3, 'a', 'b', 'c'], @array1.concat(@custom))
  end

  test "concat works with an array slice as expected" do
    assert_equal([1, 4, 5, 6], @array1[0, 1].concat(@array2))
  end

  test "concat works with a range as expected" do
    assert_equal([1, 2, 4, 5], @array1[0..1].concat(@array2[0, 2]))
  end
  
  test "passing an empty array returns the original array" do
    assert_equal(@array1, @array1.concat([]))
    assert_equal(@array1.object_id, @array1.concat([]).object_id)
  end

  test "passing an array of nils works as expected" do
    assert_equal([1, 2, 3, nil, nil], @array1.concat([nil, nil]))
  end

  test "passing an array of false values works as expected" do
    assert_equal([1, 2, 3, false, false], @array1.concat([false, false]))
  end

  test "passing an array of zeroes works as expected" do
    assert_equal([1, 2, 3, 0, 0], @array1.concat([0, 0]))
  end

  test "passing the wrong number of arguments raises an error" do
    assert_raise(ArgumentError){ @array1.concat([], []) }
  end

  test "passing the wrong type of argument raises an error" do
    assert_raise(TypeError){ @array1.concat(1) }
    assert_raise(TypeError){ @array1.concat("foo") }
  end

  def teardown
    @array1 = nil
    @array2 = nil
    @custom = nil
  end
end
