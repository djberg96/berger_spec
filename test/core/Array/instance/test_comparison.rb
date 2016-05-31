###############################################################################
# test_comparison.rb
#
# Test suite for the Array#<=> method. Note that I've added a custom class
# with its own to_ary method to ensure that Array#<=> responds to it properly.
###############################################################################
require 'test/unit'
require 'test/helper'

class Test_Array_Comparison_Instance < Test::Unit::TestCase
  include Test::Helper

  class ACompare
    def to_ary
      ['a', 'b', 'c']
    end
  end

  class NoCompare
    undef_method :<=>
  end

  def setup
    @array_chr1 = ['a', 'a', 'c']
    @array_chr2 = ['a', 'b', 'c']
    @array_int1 = [1, 2, 3, 4, 5]
    @array_int2 = [1, 2]
    @array_int3 = [1, 2]

    @nested1 = [1, [1, 2], 3]
    @nested2 = [1, [1, 2], 3]
    @nested3 = [1, [1, 2, 3]]

    @custom = ACompare.new
  end

  test "comparison basic functionality" do
    assert_respond_to(@array_chr1, :<=>)
    assert_nothing_raised{ @array_chr1 <=> @array_chr2 }
    assert_true([-1, 0, 1].include?(@array_chr1 <=> @array_chr2))
  end

  test "comparison returns expected results for simple cases" do
    assert_equal(-1, @array_chr1 <=> @array_chr2)
    assert_equal(1, @array_int1 <=> @array_int2)
    assert_equal(0, @array_int2 <=> @array_int3)
  end

  test "comparison returns expected results for nested arrays" do
    assert_equal(0, @nested1 <=> @nested2)
    assert_equal(1, @nested3 <=> @nested1)
    assert_equal(-1, @nested1 <=> @nested3)
  end

  test "comparison returns expected results for float comparisons" do
    assert_equal(0,  [1] <=> [1.000])
    assert_equal(-1, [1] <=> [1.001])
    assert_equal(1,  [1] <=> [0.999])
  end

  test "comparison returns zero when comparing two empty objects" do
    assert_equal(0, [] <=> [])
  end

  test "comparison returns the inequality if unequal comparison" do
    suppress_warning do
      assert_nil([1, 2, 3] <=> [1, "two", 3])
    end
  end

  test "comparison honors custom to_ary method as expected" do
    assert_nothing_raised{ @array_chr1 <=> @custom }
    assert_equal(0, @array_chr2 <=> @custom)
  end

  # In 1.8.x this would raise an error
  test "comparison does not raise an error for explicit nil, true or false elements" do
    assert_equal(0,  [nil] <=> [nil])
    assert_equal(0,  [true] <=> [true])
    assert_equal(0,  [false] <=> [false])
  end

  test "comparison raises an error if elements are not comparable" do
    n1 = NoCompare.new
    n2 = NoCompare.new
    assert_raise(NoMethodError){ [n1] <=> [n2] }
  end

  def teardown
    @array_chr1 = nil
    @array_chr2 = nil
    @array_int1 = nil
    @array_int2 = nil
    @array_int3 = nil

    @nested1 = nil
    @nested2 = nil
    @nested3 = nil
  end
end
