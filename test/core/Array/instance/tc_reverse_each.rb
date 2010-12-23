###########################################################
# tc_reverse_each.rb
#
# Test suite for the Array#reverse_each instance method.
###########################################################
require 'test/helper'
require "test/unit"

class TC_Array_ReverseEach_InstanceMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @array = %w[ant bat cat dog]
  end

  test "reverse_each basic functionality" do
    assert_respond_to(@array, :reverse_each)
    assert_nothing_raised{ @array.reverse_each{} }
  end

  test "reverse_each iteration works as expected" do
    i = 3
    @array.reverse_each{ |e|
      assert_equal(@array[i], e)
      i -= 1
    }
    assert_equal(-1, i)
  end

  test "reverse_each is effectively a no-op if the array is empty" do
    i = 0
    [].reverse_each{ i += 1 }
    assert_equal(0, i)
  end

  test "reverse_each does not modify the receiver" do
    assert_equal(@array, @array.reverse_each{})
  end

  test "reverse_each does not accept any arguments" do
    assert_raises(ArgumentError){ @array.reverse_each(1){} }
  end

  if PRE187
    test "reverse_each requires a block" do
      assert_raises(LocalJumpError){ @array.reverse_each }
    end
  else
    test "reverse_each without a block returns an enumerator" do
      assert_kind_of(Enumerable::Enumerator, @array.reverse_each)
    end
  end

  def teardown
    @array = nil
  end
end
