###########################################################
# test_unshift.rb
#
# Test suite for the Array#unshift instance method.
###########################################################
require 'test/helper'
require 'test/unit'

class Test_Array_Unshift_InstanceMethod < Test::Unit::TestCase
  def setup
    @array = ['a','b','c']
  end

  test "unshift basic functionality" do
    assert_respond_to(@array, :unshift)
    assert_nothing_raised{ @array.unshift }
  end

  test "unshift expected results" do
    assert_equal([1, 'a', 'b', 'c'], @array.unshift(1))
    assert_equal(['d', 2, 1, 'a', 'b', 'c'], @array.unshift('d', 2))
    assert_equal([nil, [1,2], 'd', 2, 1, 'a', 'b', 'c'], @array.unshift(nil, [1,2]))
  end

  test "unshift modifies its receiver" do
    assert_nothing_raised{ @array.unshift(1) }
    assert_equal([1, 'a', 'b', 'c'], @array)
  end

  test "unshift with splat works as expected" do
    assert_equal([1, 2, 'a', 'b', 'c'], @array.unshift(*[1,2]))
    assert_equal([[1, 2], 'a', 'b', 'c'], ['a','b','c'].unshift(*Hash[1,2]))
  end

  test "unshift without arguments returns the original array" do
    assert_equal(['a', 'b', 'c'], @array.unshift)
  end

  test "unshifting an explicit nil works as expected" do
    assert_equal([nil, 'a', 'b', 'c'], @array.unshift(nil))
    assert_equal([nil, nil], [nil].unshift(nil))
    assert_equal([nil, false], [false].unshift(nil))
  end

  def teardown
    @array = nil
  end
end
