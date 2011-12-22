############################################################################
# test_difference.rb
#
# Test suite for the Array#- instance method. Note that we define a class
# with a custom to_ary method to ensure that Array#- uses it properly.
############################################################################
require "test/unit"

class Test_Array_Difference_InstanceMethod < Test::Unit::TestCase
  class ADiff
    def to_ary
       [1, 2]
     end
  end

  def setup
    @array1 = [1, 2, 2, 3, 3, 3]
    @array2 = [2, 3]
    @array3 = [1, "hello", "world", nil, true, false]
    @array4 = [nil, true, false]
    @nested = [[1,2], ['hello', 'world']]
    @custom = ADiff.new
  end

  test "difference basic functionality" do
    assert_respond_to(@array1, :-)
    assert_nothing_raised{ @array1 - @array2 }
    assert_nothing_raised{ @array2 - @array1 }
    assert_kind_of(Array, @array1 - @array2)
  end

  test "difference when arrays contain only numbers" do
    assert_equal([1], @array1 - @array2)
    assert_equal([], @array2 - @array1)
  end

  test "difference when arrays contain a mix of types" do
    assert_nothing_raised{ @array3 - @array4 }
    assert_nothing_raised{ @array4 - @array3 }
    assert_equal([1, "hello", "world"], @array3 - @array4)
    assert_equal([], @array4 - @array3)
  end

  test "difference handles nested arrays as expected" do
    assert_equal([], @nested - [['hello','world'], [1,2]])
    assert_equal([[1,2]], @nested - [['hello','world']])
    assert_equal([[1,2], ['hello','world']], @nested - [1,2,'hello','world'])
    assert_equal([1, 2, 2, 3, 3, 3], @array1 - [[1, 2, 2, 3, 3, 3]])
  end

  test "difference returns a new array" do
    assert_nothing_raised{ @array1 - @array2 }
    assert_equal([1, 2, 2, 3, 3, 3], @array1)
    assert_equal([2, 3], @array2)
  end

  test "difference handles arrays containing explicit nils as expected" do
    assert_equal([1, 2, 2, 3, 3, 3], @array1 - [nil])
  end

  test "difference handles nested empty arrays as expected" do
    assert_equal([], [[],[],[]] - [[]])
  end

  test "substracting an empty array returns the original array" do
    assert_equal([1, 2, 2, 3, 3, 3], @array1 - [])
    assert_equal(@array1, @array1 - [])
  end

  test "the difference of empty arrays is an empty array" do
    assert_equal([], [] - [])
  end

  test "difference honors a custom to_ary method" do
    assert_nothing_raised{ @array1 - @custom }
    assert_equal([3, 3, 3], @array1 - @custom)
  end

  test "difference raises an error if the wrong argument type is passed" do
    assert_raise(TypeError){ @array1 - nil }
    assert_raise(TypeError){ @array1 - 1 }
    assert_raise(TypeError){ @array1 - "hello" }
  end

  test "an error is raised if the wrong number of arguments are passed" do
    assert_raise(ArgumentError){ @array1.send(:-, @array2, @array3) }
  end

  def teardown
    @array1 = nil
    @array2 = nil
    @array3 = nil
    @array4 = nil
    @nested = nil
  end
end
