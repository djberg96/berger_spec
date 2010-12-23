##########################################################################
# tc_flatten_bang.rb
#
# Test suite for the Array#flatten! instance method.
##########################################################################
require 'test/helper'
require "test/unit"

class TC_Array_FlattenBang_InstanceMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @array = [1,[2,3,[4,5]]]
  end

  test "flatten bang basic functionality" do
    assert_respond_to(@array, :flatten!)
    assert_nothing_raised{ @array.flatten! }
  end

  test "flatten bang returns expected results" do
    assert_equal([1,2,3,4,5], @array.flatten!)
  end

  test "flatten bang returns nil if no changes were made" do
    assert_equal(nil, [1,2,3].flatten!)
  end

  test "flatten bang modifies its receiver" do
    @array.flatten!
    assert_equal([1,2,3,4,5], @array)
  end

  test "flatten bang works as expected with empty arrays" do
    assert_equal([], [[],[],[]].flatten!)
  end

  test "flatten bang works as expected with arrays of nils" do
    expected = [nil, nil, nil, nil, nil, nil]
    assert_equal(expected, [[nil],[nil, nil],[nil, [nil, nil]]].flatten!)
  end

  if PRE187
    test "flatten bang does not accept any arguments" do
      assert_raises(ArgumentError){ @array.flatten!(1) }
    end
  else
    test "flatten bang accepts a recursion level argument" do
      assert_nothing_raised{ @array.flatten!(1) }
    end

    test "flatten bang with argument returns expected results" do
      assert_equal(@array, @array.dup.flatten!(0))
      assert_equal([1,2,3,[4,5]], @array.dup.flatten!(1))
      assert_equal([1,2,3,4,5], @array.dup.flatten!(2))
    end

    test "argument to flatten bang must be numeric" do
      assert_raises(TypeError){ @array.flatten!('foo') }
    end

    test "flatten bang with negative argument has no effect" do
      assert_equal([1,2,3,4,5], @array.flatten!(-1))
    end
  end

  def teardown
    @array = nil
  end
end
