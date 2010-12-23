###########################################################
# tc_each_index.rb
#
# Test suite for the Array#each_index instance method.
###########################################################
require 'test/helper'
require "test/unit"

class TC_Array_EachIndex_InstanceMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @array = %w[ant bat cat dog]
  end

  test "each_index basic functionality" do
    assert_respond_to(@array, :each_index)
    assert_nothing_raised{ @array.each_index{} }
  end

  test "each_index works as expected" do
    i = 0
    @array.each_index{ |index|
      assert_equal(i, index)
      i += 1
    }
    assert_equal(4, i)
    assert_equal(@array, @array.each_index{})
  end

  test "each_index does not accept arguments" do
    assert_raises(ArgumentError){ @array.each_index(1){} }
  end

  if PRE187
    test "each_index requires a block" do
      assert_raises(LocalJumpError){ @array.each_index }
    end
  else
    test "each_index returns an enumerator if no block is provided" do
      assert_kind_of(Enumerable::Enumerator, @array.each_index)
    end
  end

  def teardown
    @array = nil
  end
end
