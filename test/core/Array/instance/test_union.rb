############################################################################
# test_union.rb
#
# Test suite for the Array#| instance method. We add a custom class with
# its own to_ary method here to verify that it's handled by the Array#|
# method as well.
############################################################################
require 'test/helper'
require 'test/unit'

class Test_Array_Union_InstanceMethod < Test::Unit::TestCase
  class AUnion
    def to_ary
      [4, 5, 6]
    end
  end

  def setup
    @array1 = [1, 2, 3]
    @array2 = [3, 4, 5]
    @array3 = [4, nil, false]
    @custom = AUnion.new
  end

  test "union basic functionality" do
    assert_respond_to(@array1, :|)
    assert_nothing_raised{ @array1 | @array2 }
    assert_kind_of(Array, @array1 | @array2)
  end

  test "union expected results for typical arrays" do
    assert_equal([1, 2, 3, 4, 5], @array1 | @array2)
    assert_equal([1, 2, 3, 4, nil, false], @array1 | @array3)
  end

  test "multiple union methods can be chained" do
    assert_nothing_raised{ @array1 | @array2 | @array3 }
  end

  test "union handles custom objects with custom to_ary methods as expected" do
    assert_nothing_raised{ @array2 | @custom }
    assert_equal([3, 4, 5, 6], @array2 | @custom)
  end

  test "the union of two empty arrays is an empty array" do
    assert_equal([], [] | [])
  end

  test "explicit false and nil values are handled as expected" do
    assert_equal([nil], [nil, nil, nil] | [nil, nil, nil])
    assert_equal([nil, false], [nil, false, nil] | [false, nil, nil])
  end

  test "an error is raised if the wrong argument type is passed" do
    assert_raise(TypeError){ @array1 | 1 }
    assert_raise(TypeError){ @array1 | nil }
    assert_raise(TypeError){ @array1 | true }
    assert_raise(TypeError){ @array1 | false }
    assert_raise(TypeError){ @array1 | "hello" }
  end

  test "an error is raised if the wrong number of arguments are passed" do
    assert_raise(ArgumentError){ @array.send(:|, [], []) }
  end
   
  def teardown
    @array1 = nil
    @array2 = nil
    @array3 = nil
    @custom = nil
  end
end
