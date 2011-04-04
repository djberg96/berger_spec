#########################################################################
# test_each_with_index.rb
#
# Test suite for the Enumerable#each_with_index instance method.
#
# Note: We use a custom object here because Array and Hash have custom
# implementations.
#########################################################################
require 'test/helper'
require 'test/unit'

class MyEnumEachWithIndex
  include Enumerable

  attr_accessor :arg1, :arg2, :arg3

  def initialize(arg1='a', arg2='b', arg3='c')
    @arg1 = arg1
    @arg2 = arg2
    @arg3 = arg3
  end

  def each
    yield @arg1
    yield @arg2
    yield @arg3
  end
end

class TC_Enumerable_EachWithIndex_InstanceMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @enum  = MyEnumEachWithIndex.new
    @array = []
  end

  test "each_with_index basic functionality" do
    assert_respond_to(@enum, :each_with_index)
    assert_nothing_raised{ @enum.each_with_index{} }
  end

  test "each_with_index returns the expected results" do
    assert_nothing_raised{ @enum.each_with_index{ |e, i| @array[i] = e } }
    assert_equal(['a', 'b', 'c'], @array)
    assert_equal('a', @array[0])
  end

  test "each_with_index returns the original object if the block is empty" do
    assert_equal(@enum, @enum.each_with_index{})
  end

  test "each_with_index does not accept any arguments" do
    assert_raise(ArgumentError){ @enum.each_with_index(true) }
  end

  test "each_with_index behaves as expected when no block is provided" do
    if PRE187
      assert_raise(LocalJumpError){ @enum.each_with_index }
    else
      assert_kind_of(Enumerable::Enumerator, @enum.each_with_index)
    end
  end

  def teardown
    @enum  = nil
    @array = nil
  end
end
