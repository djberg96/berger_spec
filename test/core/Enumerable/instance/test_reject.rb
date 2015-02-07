#########################################################################
# test_reject.rb
#
# Test suite for the Enumerable#reject instance method.
#########################################################################
require 'test/helper'
require 'test/unit'

class MyEnumReject
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

class TC_Enumerable_Reject_InstanceMethod < Test::Unit::TestCase
  def setup
    @enum = MyEnumReject.new(1,2,3)
  end

  test "reject basic functionality" do
    assert_respond_to(@enum, :reject)
    assert_nothing_raised{ @enum.reject{} }
  end

  test "reject returns expected results" do
    assert_equal([1,2,3], @enum.reject{ |e| e > 7 })
    assert_equal([1], @enum.reject{ |e| e > 1 })
  end

  test "reject with explicit false and nil works as expected" do
    @enum = MyEnumReject.new(nil, nil, false)
    assert_equal([false], @enum.reject{ |e| e.nil? })
    assert_equal([nil, nil], @enum.reject{ |e| e == false })
    assert_equal([nil, nil, false], @enum.reject{})
  end

  test "reject returns an empty array if true is sent to block" do
    assert_equal([], @enum.reject{ true })
  end

  test "reject returns original object if block is empty" do
    assert_equal([1,2,3], @enum.reject{})
  end

  test "reject returns an Enumerator object if no block is given" do
    assert_kind_of(Enumerator, @enum.reject)
  end

  test "reject does not accept any arguments" do
    assert_raise(ArgumentError){ @enum.reject(5) }
  end

  def teardown
    @enum   = nil
  end
end
