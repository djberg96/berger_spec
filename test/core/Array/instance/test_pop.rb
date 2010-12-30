################################################################
# tc_pop.rb
#
# Test suite for the Array#pop instance method.
################################################################
require 'test/helper'
require "test/unit"

class TC_Array_Pop_Instance < Test::Unit::TestCase
  include Test::Helper

  def setup
    @array = %w/a b c/
  end

  test "pop basic functionality" do
    assert_respond_to(@array, :pop)
    assert_nothing_raised{ @array.pop }
  end

  test "pop returns expected results with no arguments" do
    assert_equal("c", @array.pop)
    assert_equal("b", @array.pop)
    assert_equal("a", @array.pop)
  end

  test "pop modifies the receiver" do
    assert_nothing_raised{ @array.pop }
    assert_equal(%w[a b], @array)
  end

  test "pop returns nil if the array is empty" do
    assert_equal(nil, [].pop)
  end

  if PRE187
    test "pop does not take any arguments" do
      assert_raises(ArgumentError){ @array.pop(1) }
      assert_raises(ArgumentError){ @array.pop("foo") }
    end
  else
    test "pop accepts a numeric argument" do
      assert_nothing_raised{ @array.pop(2) }
    end

    test "pop with a numeric argument returns expected results" do
      assert_equal([], %w[a b c].pop(0))
      assert_equal(['c'], %w[a b c ].pop(1))
      assert_equal(['b', 'c'], %w[a b c].pop(2))
      assert_equal(['a', 'b', 'c'], %w[a b c].pop(3))
      assert_equal(['a', 'b', 'c'], %w[a b c ].pop(99))
    end

    test "argument to pop must be a number if present" do
      assert_raises(TypeError){ @array.pop("foo") }
    end

    test "argument to pop must be positive" do
      assert_raises(ArgumentError){ @array.pop(-1) }
    end

    test "pop accepts a maximum of one argument" do
      assert_raises(ArgumentError){ @array.pop(1, 2) }
    end
  end

  def teardown
    @array = nil
  end
end
