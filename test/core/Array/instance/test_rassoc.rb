###########################################################
# test_rassoc.rb
#
# Test suite for the Array#rassoc instance method.
###########################################################
require 'test/helper'
require "test/unit"

class Test_Array_RAssoc_InstanceMethod < Test::Unit::TestCase
  def setup
    @array = [[false,"one"], [2,"two"], [nil,"three"], ["ii","two"], [1,nil]]
  end

  test "rassoc basic functionality" do
    assert_respond_to(@array, :rassoc)
    assert_nothing_raised{ @array.rassoc("two") }
    assert_kind_of([Array, NilClass], @array.rassoc("two"))
  end

  test "rassoc expected array results" do
    assert_equal([2, "two"], @array.rassoc("two"))
    assert_equal([false, "one"], @array.rassoc("one"))
    assert_equal([nil, "three"], @array.rassoc("three"))
    assert_equal([1, nil], @array.rassoc(nil))
  end

  test "rassoc expected nil results" do
    assert_nil(@array.rassoc(false))
    assert_nil(@array.rassoc(2))
    assert_nil(@array.rassoc("ii"))
    assert_nil(@array.rassoc(1))
  end

  test "rassoc handles nested empty arrays properly" do
    assert_nil([[],[]].rassoc([]))
  end

  test "rassoc handles empty strings properly" do
    assert_equal([1, ''], [[1, ''], [2, nil], [3, false]].rassoc(''))
  end

  test "rassoc raises an error if the wrong number of arguments are passed" do
    assert_raise(ArgumentError){ @array.rassoc }
    assert_raise(ArgumentError){ @array.rassoc(1,2) }
  end

  def teardown
    @array = nil
  end
end
