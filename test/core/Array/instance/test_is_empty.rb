###########################################################
# test_is_empty.rb
#
# Test suite for the Array#empty? instance method.
###########################################################
require 'test/helper'
require "test/unit"

class Test_Array_IsEmpty_InstanceMethod < Test::Unit::TestCase
  def setup
    @array1 = [1,2,3]
    @array2 = []
    @array3 = [nil]
  end

  test "is empty basic functionality" do
    assert_respond_to(@array1, :empty?)
    assert_nothing_raised{ @array1.empty? }
    assert_boolean(@array1.empty?)
  end

  test "is empty expected results" do
    assert_false(@array1.empty?)
    assert_true(@array2.empty?)
    assert_false(@array3.empty?)
  end

  test "an empty string is still considered an element" do
    assert_false([''].empty?)
  end

  test "explicit zero is still considered an element" do
    assert_false([0].empty?)
  end

  test "an error is raised if the wrong number of arguments are passed" do
    assert_raise(ArgumentError){ @array1.empty?(false) }
  end

  def teardown
    @array1 = nil
    @array2 = nil
    @array3 = nil
  end
end
