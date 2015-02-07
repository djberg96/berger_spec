#########################################################################
# test_find_all.rb
#
# Test suite for the Enumerable#find_all instance method and the
# Enumerable#select alias.
#########################################################################
require 'test/helper'
require 'test/unit'

class MyEnumFindAll
  include Enumerable

  attr_accessor :arg1, :arg2, :arg3

  def initialize(arg1, arg2, arg3)
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

class TC_Enumerable_FindAll_InstanceMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @enum = MyEnumFindAll.new(1,2,3)
  end

  test "find_all basic functionality" do
    assert_respond_to(@enum, :find_all)
    assert_nothing_raised{ @enum.find_all{} }
  end

  test "find_all returns the expected results" do
    assert_equal([2,3], @enum.find_all{ |e| e > 1 })
    assert_equal([], @enum.find_all{ |e| e > 7 })
  end

  test "find_all works with explicitly false and nil elements" do
    @enum = MyEnumFindAll.new(nil, nil, false)
    assert_equal([nil, nil], @enum.find_all{ |e| e.nil? })
    assert_equal([false], @enum.find_all{ |e| e == false })
    assert_equal([], @enum.find_all{})
  end

  test "find_all returns the original object if the block returns true" do
    assert_equal([1,2,3], @enum.find_all{ true })
  end

  test "find_all returns an empty array if the block is empty" do
    assert_equal([], @enum.find_all{})
  end

  test "select is an alias for find_all" do
    msg = '=> Known issue in MRI'
    assert_respond_to(@enum, :select)
    assert_alias_method(@enum, :find_all, :select, msg)
  end

  test "find_all does not accept any arguments" do
    assert_raise(ArgumentError){ @enum.find_all(5) }
  end

  test "find_all behavior when no block is provided" do
    if PRE187
      assert_raise(LocalJumpError){ @enum.find_all }
    else
      assert_kind_of(Enumerator, @enum.find_all)
    end
  end

  def teardown
    @enum   = nil
  end
end
