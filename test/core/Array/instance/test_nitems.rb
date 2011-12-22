######################################################
# test_nitems.rb
#
# Test suite for the Array#nitems instance method.
######################################################
require 'test/helper'
require "test/unit"

class Test_Array_NItems_InstanceMethod < Test::Unit::TestCase
  def setup
    @array  = [1, nil,"two", nil, 3]
    @nested = [1, nil, [2, nil], 3, [nil, 4]]
  end

  test "nitems basic functionality" do
    assert_respond_to(@array, :nitems)
    assert_nothing_raised{ @array.nitems }
    assert_kind_of(Fixnum, @array.nitems)
  end

  test "nitems expected results" do
    assert_equal(3, @array.nitems)
    assert_equal(0, [nil, nil].nitems)
    assert_equal(1, [false, nil].nitems)
  end

  test "nitems returns expected result for nested array" do
    assert_equal(4, @nested.nitems)
  end

  test "nitems returns expected result for empty array" do
    assert_equal(0, [].nitems)
  end

  test "nitems returns expected result for recursive array" do
    @array = [1, 2, 3, nil]; @array = @array << @array
    assert_equal(4, @array.nitems)
  end

  test "nitems raises an error if the wrong number of arguments are passed" do
    assert_raise(ArgumentError){ @array.nitems(1) }
  end

  def teardown
    @array  = nil
    @nested = nil
  end
end
