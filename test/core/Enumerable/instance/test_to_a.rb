#########################################################################
# test_to_a.rb
#
# Test suite for the Enumerable#to_a instance method and the
# Enumerable#entries alias.
#########################################################################
require 'test/helper'
require 'test/unit'

class MyEnumToA
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

class TC_Enumerable_ToA_InstanceMethod < Test::Unit::TestCase
  def setup
    @enum = MyEnumToA.new(1,2,3)
  end

  test "to_a basic functionality" do
    assert_respond_to(@enum, :to_a)
    assert_nothing_raised{ @enum.to_a }
    assert_kind_of(Array, @enum.to_a)
  end

  test "to_a returns the expected results" do
    assert_equal([1, 2, 3], @enum.to_a)
  end

  test "to_a handles explicit nils as expected" do
    assert_equal([nil, nil, nil], MyEnumToA.new(nil, nil, nil).to_a)
  end

  test "entries is an alias for to_a" do
    assert_respond_to(@enum, :entries)
    assert_alias_method(@enum, :to_a, :entries)
  end

  test "to_a does not accept any arguments" do
    assert_raise(ArgumentError){ @enum.to_a(true) }
  end

  def teardown
    @enum = nil
  end
end
