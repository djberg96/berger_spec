###########################################################
# test_reject_bang.rb
#
# Test suite for the Array#reject! instance method.
###########################################################
require 'test/helper'
require "test/unit"

class Test_Array_RejectBang_InstanceMethod < Test::Unit::TestCase
  def setup
    @array = [1, 2, 3, 4]
  end

  test "reject bang basic functionality" do
    assert_respond_to(@array, :reject!)
    assert_nothing_raised{ @array.reject!{} }
    assert_kind_of([Array, NilClass], @array.reject!{})
  end

  test "reject bang returns array if changes are made" do
    assert_nothing_raised{ @array.reject!{ |x| x > 2 } }
    assert_equal([1, 2], @array)
  end

  test "reject bang returns nil if no changes are made" do
    assert_nil(@array.reject!{ |x| x > 5 })
  end

  test "reject bang deletes all values if block evaluates to true" do
    assert_nothing_raised{ @array.reject!{ true } }
    assert_equal([], @array)
  end

  test "reject bang handles explicit nil as expected" do
    @array = [nil, true, false]
    assert_nothing_raised{ @array.reject!{ |x| x.nil? } }
    assert_equal([true, false], @array)
  end

  test "an error is raised if the wrong number of arguments are passed" do
    assert_raise(ArgumentError){ @array.reject!(1) }
  end

  def teardown
    @array = nil
  end
end
