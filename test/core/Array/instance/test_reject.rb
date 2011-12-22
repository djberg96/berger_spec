###########################################################
# test_reject.rb
#
# Tests for the Array#reject instance method. Although
# this method is mixed in from the Enumerable module,
# these tests remain because the array.c source file
# originally contained its own implementation.
###########################################################
require 'test/helper'
require 'test/unit'

class Test_Array_Reject_InstanceMethod < Test::Unit::TestCase
  def setup
    @array = [1, 2, 3, 4]
  end

  test "reject basic functionality" do
    assert_respond_to(@array, :reject)
    assert_nothing_raised{ @array.reject{} }
    assert_kind_of([Array, NilClass], @array.reject{})
  end

  test "reject returns expected results" do
    assert_equal([1, 2], @array.reject{ |x| x > 2 })
    assert_equal([1, 3], @array.reject{ |x| x % 2 == 0 })
  end

  test "reject does not modify its receiver" do
    assert_nothing_raised{ @array.reject{ 1 } }
    assert_equal([1, 2, 3, 4], @array)
  end

  test "reject returns original contents if no changes are made" do
    assert_equal([1, 2, 3, 4], @array.reject{ false })
    assert_equal([1, 2, 3, 4], @array.reject{ nil })
  end

  test "reject deletes all values if block evaluates to true" do
    assert_equal([], @array.reject{ true })
    assert_equal([], @array.reject{ 1 })
  end

  test "reject handles explicit nil and false elements as expected" do
    @array = [nil, true, false]
    assert_equal([true, false], @array.reject{ |x| x.nil? })
    assert_equal([nil, true], @array.reject{ |x| x == false })
  end

  test "reject handles recursive arrays properly" do
    array = @array << @array
    assert_equal([], array.reject{ true })
    assert_equal(array, array.reject{ false })
  end

  test "an error is raised if the wrong number of arguments are passed" do
    assert_raise(ArgumentError){ @array.reject(1) }
  end

  def teardown
    @array = nil
  end
end
