######################################################################
# test_any.rb
#
# Test case for the Enumerable#any? instance method.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_Enumerable_Any_InstanceMethod < Test::Unit::TestCase
  def setup
    @enum = ['a', 'b', 'c']
  end

  test "any? basic functionality" do
    assert_respond_to(@enum, :any?)
    assert_nothing_raised{ @enum.any? }
    assert_nothing_raised{ @enum.any?{ } }
  end

  test "any? without a block returns the expected results" do
    assert_true([1, 2, 3].any?)
    assert_true([nil, false, true].any?)
    assert_false([nil, false].any?)
  end

  test "any? with a block returns the expected results" do
    assert_equal(true, [1, 2, 3].any?{ |e| e > 1 })
    assert_equal(false, [1, 2, 3].any?{ |e| e > 7 })
  end

  test "any? with explicit false or nil works as expected" do
    assert_true([false, nil].any?{ |e| e.nil? })
    assert_true([false, nil].any?{ |e| e == false })
  end

  test "any? with explicit zero or true works as expected" do
    assert_true([0].any?)
    assert_true([true].any?)
  end

  test "calling any? on an empty enumerable object returns false" do
    assert_equal(false, [].any?)
  end

  test "any? with an argument works as expected" do
    assert_true([1, 2, 3].any?(1))
    assert_false([1, 2, 3].any?(4))
  end

  test "any? accepts only one argument" do
    assert_raise(ArgumentError){ [1, 2, 3].any?(1, 2) }
  end

  def teardown
    @enum = nil
  end
end
