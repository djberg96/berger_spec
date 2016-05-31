#############################################################################
# test_transpose.rb
#
# Test suite for the Array#transpose method.
#############################################################################
require 'test/helper'
require 'test/unit'

class TC_Array_Transpose_InstanceMethod < Test::Unit::TestCase
  class ATranspose < Array
    def to_ary
      [[1,2], [3,4]]
    end
  end

  def setup
    @array  = [['a','b'], ['c','d'], ['e','f'], ['g','h']]
    @custom = ATranspose.new
  end

  test 'transpose basic functionality' do
    assert_respond_to(@array, :transpose)
    assert_nothing_raised{ @array.transpose }
  end

  test "transpose returns the expected results" do
    assert_equal([['a','c','e','g'],['b','d','f','h']], @array.transpose)
    assert_equal([[1, 3], [2, 4], [[3], [5, 6]]], [[1,2,[3]],[3,4,[5,6]]].transpose)
  end

  test "transpose does not modify its receiver" do
    assert_nothing_raised{ @array.transpose }
    assert_equal([['a','b'],['c','d'],['e','f'],['g','h']], @array)
  end

  test "transposing a transposed array returns the original array" do
    assert_equal([['a','b'],['c','d'],['e','f'],['g','h']], @array.transpose.transpose)
  end

=begin
  test "transpose responds to custom to_ary methods" do
    pend("transpose tests for custom to_ary method awaiting clarification")
    assert_nothing_raised{ @custom.transpose }
    assert_equal([[1,3], [2,4]], @custom.transpose)
  end
=end

  test "calling transpose on an empty array returns an empty array" do
    assert_equal([], [].transpose)
  end

  test "calling transpose on an array of empty arrays returns an empty array" do
    assert_equal([], [[], []].transpose)
  end

  test "transpose handles nil, false and true elements properly" do
    assert_equal([[nil, false], [nil, true]], [[nil, nil], [false, true]].transpose)
  end

  test "transpose can handle recursive arrays" do
    array = []
    array << array << array
    expected = "[[[[...], [...]], [[...], [...]]], [[[...], [...]], [[...], [...]]]]"
    assert_nothing_raised{ array.transpose }
    assert_equal(expected, array.transpose.to_s)
  end

  test "transpose raises an error if it does not contain nested arrays" do
    assert_raise(TypeError){ [1,2,3].transpose }
  end

  test "transpose raises an error if element sizes differ" do
    assert_raise(IndexError){ [[1,2],[3]].transpose }
    assert_raise(IndexError){ [[1,2,3],[3,4]].transpose }
  end

  test "transpose does not accept any arguments" do
    assert_raise(ArgumentError){ @array.transpose(1) }
  end

  def teardown
    @array  = nil
    @custom = nil
  end
end
