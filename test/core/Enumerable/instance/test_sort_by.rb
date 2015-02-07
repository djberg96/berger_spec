###############################################################################
# test_sort_by.rb
#
# Test case for the Enumerable#sort_by instance method.
###############################################################################
require 'test/helper'
require 'test-unit'

class TC_Enumerable_SortBy_InstanceMethod < Test::Unit::TestCase
  def setup
    @words = ['apple', 'pear', 'fig']
    @nums  = [1, 0, -1, 77, 15]
    @mixed = [Time.now, 0, nil, true, false, 'hello']
  end

  test "sort_by basic functionality" do
    assert_respond_to(@words, :sort_by)
    assert_nothing_raised{ @words.sort_by{ |w| w.length } }
  end

  test "sort_by returns the expected result" do
    assert_equal(['fig', 'pear', 'apple'], @words.sort_by{ |w| w.length })
    assert_equal([0, 1, -1, 15, 77], @nums.sort_by{ |n| n.abs })
  end

  test "sort_by on an empty array returns an empty array" do
    assert_equal([], [].sort_by{ |n| n.to_s })
  end

  test "sort_by with explicit nil elements returns the expected result" do
    assert_equal([nil, nil], [nil, nil].sort_by{ |n| n.to_s })
  end

  test "sort_by with no block returns an Enumerator" do
    assert_kind_of(Enumerator, @words.sort_by)
  end

  test "sort_by with an empty block returns the original receier" do
    assert_nothing_raised{ @words.sort_by{} }
    assert_kind_of(Array, @words.sort_by{})
    assert_equal(@words, @words.sort_by{})
  end

  test "sort_by does not accept any arguments" do
    assert_raise(ArgumentError){ @words.sort_by(1) }
  end

  test "calling an invalid method within a block raises a NoMethodError" do
    assert_raise(NoMethodError){ @mixed.sort_by{ |m| m.length } }
  end

  def teardown
    @words = nil
    @nums  = nil
    @mixed = nil
  end
end
