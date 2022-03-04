################################################
# test_repetition.rb
#
# Test suite for the Array#* instance method.
################################################
require 'test/helper'
require "test/unit"

class Test_Array_Repetition_InstanceMethod < Test::Unit::TestCase
  def setup
    @array_nums = [1, 2, 3]
    @array_word = ["hello", "world"]
    @array_edge = [true, false, nil]
    @array_nest = [[1,2], ['a','b']]
  end

  test "repetition basic functionality" do
    assert_respond_to(@array_nums, :*)
    assert_nothing_raised{ @array_nums * 'x' }
    assert_kind_of([Array, String], @array_nums * 'x')
  end

  test "repetitition results for numeric argument" do
    assert_nothing_raised{ @array_nums * 2 }
    assert_equal([1, 2, 3, 1, 2, 3], @array_nums * 2)
    assert_equal(["hello", "world", "hello", "world"], @array_word * 2)
    assert_equal([true, false, nil, true, false, nil], @array_edge * 2)
  end

  test "repetition results for string argument" do
    assert_nothing_raised{ @array_nums * "-" }
    assert_equal("1-2-3", @array_nums * "-")
    assert_equal("hello-world", @array_word * "-")
    assert_equal("true-false-", @array_edge * "-")
  end

  test "repetition with nested arrays returns expected results" do
    assert_nothing_raised{ @array_nest * 2 }
    assert_equal([[1, 2],['a', 'b'],[1, 2],['a', 'b']], @array_nest * 2)
    assert_equal("1-2-a-b", @array_nest * "-")
  end

  test "arrays containing explicit nil and false return expected results" do
    assert_equal("", [nil] * "-")
    assert_equal("", [] * "-")
    assert_equal("false", [false] * "-")
    assert_equal([1, 2, 3], @array_nums * 1.9)
  end

  test "passing an argument of 0 returns an empty array" do
    assert_nothing_raised{ @array_nums * 0 }
    assert_equal([], @array_nums * 0)
  end

  test "passing anything other than a string or numeric raises an error" do
    assert_raise(TypeError){ @array_nums * nil }
    assert_raise(TypeError){ @array_nums * @array_word }
    assert_raise(TypeError){ @array_nums * false }
  end

  test "passing the wrong number of arguments raises an error" do
    assert_raise(ArgumentError){ @array_nums.send(:*, @array_nums, @array_word) }
  end

  test "passing a negative numeric value is illegal" do
    assert_raise(ArgumentError){ @array_nums * -3 }
  end

  test "passing a value that is too large raises an error" do
    assert_raise(ArgumentError, RangeError){ @array_nums * (256**64) }
  end

  def teardown
    @array_nums = nil
    @array_word = nil
    @array_edge = nil
    @array_nest = nil
  end
end
