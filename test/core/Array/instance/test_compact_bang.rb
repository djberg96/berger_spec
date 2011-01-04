##############################################################################
# test_compact_bang.rb
#
# Test suite for the Array#compact! instance method. The tests for the
# Array#compact instance method can be found in the test_compact.rb file.
##############################################################################
require 'test/helper'
require 'test/unit'

class Test_Array_CompactBang_InstanceMethod < Test::Unit::TestCase
  def setup
    @array1 = [1, 'two', nil, false, nil]
    @array2 = [0, 1, 2, 3]
  end

  test "compact bang basic functionality" do
    assert_respond_to(@array1, :compact!)
    assert_nothing_raised{ @array1.compact! }
    assert_kind_of([Array, NilClass], @array1.compact!)
  end

  test "compact bang returns expected value" do
    assert_equal([1, 'two', false], @array1.compact!)
    assert_nil(@array2.compact!)
  end

  test "compact bang modifies its receiver" do
    assert_nothing_raised{ @array1.compact! }
    assert_equal([1, 'two', false], @array1)
  end

  test "compact bang on an empty array returns nil" do
    assert_equal(nil, [].compact!)
  end

  test "compact bang on an array the only contains nil returns nil" do
    assert_equal([], [nil].compact!)
  end

  test "nested arrays that contain nil are handled as expected" do
    assert_equal(nil, [[nil]].compact!)
  end

  test "the wrong number of arguments raises an error" do
    assert_raise(ArgumentError){ @array1.compact!(1) }
  end

  def teardown
    @array1 = nil
    @array2 = nil
  end
end
