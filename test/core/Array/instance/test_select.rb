########################################################################
# test_select.rb
#
# Tests for the Array#select instance method. Although Array#select
# is mixed in from Enumerable, these tests remain in place because
# the array.c source file has its own implementation.
########################################################################
require 'test/helper'
require 'test/unit'

class TC_Array_Select_InstanceMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @array = ['alpha', 1, 'beta', 2.1, ['a', 'b', 'c']]
  end

  test "select basic functionality" do
    assert_respond_to(@array, :select)
    assert_nothing_raised{ @array.select{} }
  end

  test "select returns an array when a match is found" do
    assert_equal(['alpha', 'beta'], @array.select{ |e| e =~ /\w/i })
    assert_equal([1], @array.select{ |e| e.kind_of?(Integer) })
  end

  test "select returns an empty array when no match is found" do
    assert_equal([], @array.select{ |e| e == 'bogus' })
  end

  test "find_all handles explicit nil and false as expected" do
    assert_equal([nil, nil], [nil, nil].select{ |e| e.nil? })
    assert_equal([false, false], [false, false].select{ |e| e == false })
  end

  test "calling select on an empty array returns expected result" do
    assert_equal(0, [].select.count)
    assert_equal(0, [].select{}.count)
  end

  test "select returns the original object if non-false object is yielded" do
    assert_equal(@array, @array.select{ true })
    #assert_equal(@array.object_id, @array.select{ true }.object_id)
  end

  test "select with no block exhibits the expected behavior" do
    assert_kind_of(Enumerator, @array.select)
  end

  test "select does not take any arguments" do
    assert_raise(ArgumentError){ @array.select('alpha') }
  end

  def teardown
    @array = nil
  end
end
