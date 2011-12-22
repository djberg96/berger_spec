#######################################################################
# test_reverse.rb
#
# Test suite for the Array#reverse instance method. The tests for the
# Array#reverse! instance method are in test_reverse_bang.rb.
#######################################################################
require 'test/helper'
require 'test/unit'

class Test_Array_Reverse_InstanceMethod < Test::Unit::TestCase
  def setup
    @array = [1, 2, 3]
  end

  test "reverse basic functionality" do
    assert_respond_to(@array, :reverse)
    assert_nothing_raised{ @array.reverse }
    assert_kind_of(Array, @array.reverse)
  end

  test "reverse expected results for basic arrays" do
    assert_equal([1], [1].reverse)
    assert_equal([3, 2, 1], @array.reverse)
    assert_equal([nil, false, nil], [nil, false, nil].reverse)
  end

  test "reverse does not modify receiver" do
    assert_nothing_raised{ @array.reverse }
    assert_equal([1, 2, 3], @array)
  end

  test "reverse on an empty array returns an empty array" do
    assert_nothing_raised{ [].reverse }
    assert_equal([], [].reverse)
  end

  test "reverse returns expected results for recursive arrays" do
    array = @array << @array
    assert_nothing_raised{ array = @array.reverse }
    assert_equal("[[1, 2, 3, [...]], 3, 2, 1]", array.inspect)
  end

  test "passing the wrong number of arguments raises an error" do
    assert_raise(ArgumentError){ @array.reverse(1) }
  end

  def teardown
     @array = nil
  end
end
