######################################################################
# test_all.rb
#
# Test case for the Enumerable#all? instance method.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_Enumerable_All_InstanceMethod < Test::Unit::TestCase
  def setup
    @enum = ['a', 'b', 'c']
  end

  test "all? basic functionality" do
    assert_respond_to(@enum, :all?)
    assert_nothing_raised{ @enum.all? }
    assert_nothing_raised{ @enum.all?{ } }
  end

  test "all? without a block returns the expected result" do
    assert_true([1, 2, 3].all?)
    assert_false([nil, false, true].all?)
    assert_false([nil, false].all?)
  end

  test "all? with a block returns the expected result" do
    assert_false([1, 2, 3].all?{ |e| e > 1 })
    assert_true([1, 2, 3].all?{ |e| e > 0 })
  end

  test "all? with an explicit nil or false works as expected" do
    assert_true([nil].all?{ |e| e.nil? })
    assert_true([false].all?{ |e| e == false })
  end

  test "calling all? on an empty array returns true" do
    assert_equal(true, [].all?)
  end

  test "calling all? on a zero element returns true" do
    assert_equal(true, [0].all?)
  end

  test "calling all? on an explicitly true element returns true" do
    assert_equal(true, [true].all?)
  end

  test "all? does not accept any arguments" do
    assert_raise(ArgumentError){ [1, 2, 3].all?(1) }
  end

  def teardown
    @enum = nil
  end
end
