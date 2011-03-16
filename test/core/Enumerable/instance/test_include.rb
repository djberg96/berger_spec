#########################################################################
# test_include.rb
#
# Test suite for the Enumerable#include instance method and the
# Enumerable#member? alias.
#########################################################################
require 'test/helper'
require 'test/unit'

class MyEnumInclude
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

class TC_Enumerable_Include_InstanceMethod < Test::Unit::TestCase
  def setup
    @enum = MyEnumInclude.new('alpha', 7, 'beta')
  end

  test "include? basic functionality" do
    assert_respond_to(@enum, :include?)
    assert_nothing_raised{ @enum.include?(1) }
  end

  test "include? returns the expected results" do
    assert_true(@enum.include?('alpha'))
    assert_true(@enum.include?(7))
    assert_true(@enum.include?('beta'))
    assert_false(@enum.include?('7'))
    assert_false(@enum.include?(8))
  end

  test "include? works as expected with explicit nil and false members" do
    @enum = MyEnumInclude.new(true, false, nil)
    assert_true(@enum.include?(true))
    assert_true(@enum.include?(false))
    assert_true(@enum.include?(nil))
  end

  test "member? is an alias for include?" do
    msg = '=> Known issue in MRI'
    assert_respond_to(@enum, :member?)
    assert_alias_method(@enum, :member?, :include?)
  end

  test "include? requires one and only one argument" do
    assert_raise(ArgumentError){ @enum.include? }
    assert_raise(ArgumentError){ @enum.include?(5, 7) }
  end

  def teardown
    @enum   = nil
  end
end
