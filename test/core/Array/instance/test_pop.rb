################################################################
# test_pop.rb
#
# Test suite for the Array#pop instance method.
################################################################
require 'test/helper'
require "test/unit"

class Test_Array_Pop_Instance < Test::Unit::TestCase
  def setup
    @array = %w/a b c/
  end

  test "pop basic functionality" do
    assert_respond_to(@array, :pop)
    assert_nothing_raised{ @array.pop }
  end

  test "pop expected results" do
    assert_equal("c", @array.pop)
    assert_equal("b", @array.pop)
    assert_equal("a", @array.pop)
  end

  test "pop returns nil if called on an empty array" do
    assert_nil([].pop)
  end

  test "pop handles explicit nil as expected" do
    assert_nil([nil].pop)
  end

  test "pop handles nested arrays as expected" do
    assert_equal([], [[]].pop)
  end

  test "pop returns expected result for recursive arrays" do
    @array = @array << @array
    assert_equal(['a', 'b', 'c'], @array.pop)
    assert_equal('c', @array.pop)
  end

  test "pop raises an error if the wrong number of arguments are passed" do
    assert_raise(ArgumentError){ @array.pop("foo") }
  end

  def teardown
    @array = nil
  end
end
