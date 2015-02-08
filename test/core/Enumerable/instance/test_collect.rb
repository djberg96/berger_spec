#########################################################################
# test_collect.rb
#
# Test suite for the Enumerable#collect instance method and the
# Enumerable#map alias.
#
# Note: I've created my own class here because other classes tend to
# implement their own custom version of collect/map.
#########################################################################
require 'test/helper'
require 'test/unit'

class MyEnumCollect
  include Enumerable

  attr_accessor :arg1, :arg2, :arg3

  def initialize(arg1=1, arg2=2, arg3=3)
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

class TC_Enumerable_Collect_InstanceMethod < Test::Unit::TestCase
  def setup
    @enum = MyEnumCollect.new(1, 2, 3)
  end

  test "collect basic functionality" do
    assert_respond_to(@enum, :collect)
    assert_nothing_raised{ @enum.collect }
  end

  test "collect returns the expected results" do
    assert_equal([2,3,4], @enum.collect{ |e| e += 1 })
    assert_equal([7,7,7], @enum.collect{ 7 })
  end

  test "collect honors custom each method definition" do
    assert_equal(['a','a','a'], @enum.collect{ 'a' })
  end

  test "collect yields an array of nils when given an empty block" do
    assert_equal([nil, nil, nil], @enum.collect{})
  end

  test "collect with no block returns an enumerator" do
    assert_kind_of(Enumerator, @enum.collect)
  end

  test "map is an alias for collect" do
    assert_respond_to(@enum, :map)
    assert_alias_method(@enum, :collect, :map)
  end

  test "collect does not accept any arguments" do
    assert_raise(ArgumentError){ @enum.collect(5) }
  end

  def teardown
    @enum = nil
  end
end
