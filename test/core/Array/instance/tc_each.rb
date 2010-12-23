###########################################################
# tc_each.rb
#
# Test suite for the Array#each instance method.
###########################################################
require 'test/helper'
require "test/unit"

class TC_Array_Each_InstanceMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @array = ["ant", "bat", "cat", "dog"]
  end

  test "each basic functionality" do
    assert_respond_to(@array, :each)
    assert_nothing_raised{ @array.each{} }
  end

  test "each iterates over an array as expected" do
    i = 0
    @array.each{ |e|
      assert_equal(@array[i], e)
      i += 1
    }
    assert_equal(4, i)
  end

  test "calling each on an empty array is effectively a no-op" do
    i = 0
    [].each{ i += 1 }
    assert_equal(0, i)
    assert_equal(@array, @array.each{})
  end

  test "each does not accept any arguments" do
    assert_raises(ArgumentError){ @array.each(1){} }
  end

  if PRE187
    test "each requires a block" do
      assert_raises(LocalJumpError){ @array.each }
    end
  else
    test "each returns an enumerator if no block is given" do
      assert_kind_of(Enumerable::Enumerator, @array.each)
    end
  end

  def teardown
    @array = nil
  end
end
