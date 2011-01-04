###########################################################
# test_is_eql.rb
#
# Test for the Array#eql? instance method.
###########################################################
require 'test/helper'
require "test/unit"

class Test_Array_IsEql_InstanceMethod < Test::Unit::TestCase
  def setup
    @array1 = [1,2,3]
    @array2 = [1,2,3]
    @array3 = [3,2,1]
  end

  test "is eql basic functionality" do
    assert_respond_to(@array1, :eql?)
    assert_nothing_raised{ @array1.eql?(@array2) }
    assert_boolean(@array1.eql?(@array2))
  end

  test "is eql expected results" do
    assert_true(@array1.eql?(@array1))
    assert_true(@array1.eql?(@array2))
    assert_false(@array1.eql?(@array3))
  end

  test "is eql always returns false when checked against non array types" do
    assert_false(@array1.eql?(nil))
    assert_false(@array1.eql?(1))
    assert_false(@array1.eql?(false))
  end

  test "is eql compares two empty arrays as expected" do
    assert_true([].eql?([]))
  end

  test "is eql compares nested arrays as expected" do
    assert_true([[]].eql?([[]]))
    assert_true([[nil]].eql?([[nil]]))
    assert_true([[false]].eql?([[false]]))
  end

  test "is eql returns expected values for recursive arrays" do
    recursive1 = @array1 << @array1
    recursive2 = @array2 << @array2
    assert_true(recursive1.eql?(recursive1))
    assert_false(recursive1.eql?(recursive2))
  end

  test "is eql raises an error if the wrong number of arguments are passed" do
    assert_raise(ArgumentError){ @array1.eql? }
    assert_raise(ArgumentError){ @array1.eql?([1],[2]) }
  end

  def teardown
    @array1 = nil
    @array2 = nil
    @array3 = nil
  end
end
