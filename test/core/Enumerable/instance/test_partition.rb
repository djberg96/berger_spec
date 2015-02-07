########################################################################
# test_partition.rb
#
# Test case for the Enumerable#partition instance method.
########################################################################
require 'test/helper'
require 'test-unit'

class TC_Enumerable_Partition_InstanceMethod < Test::Unit::TestCase
  def setup
    @enum = [1,2,3,4,5]
  end

  test "partition basic functionality" do
    assert_respond_to(@enum, :partition)
    assert_nothing_raised{ @enum.partition{} }
    assert_equal(2, @enum.partition{}.length)
    assert_kind_of(Array, @enum.partition{}[0])
    assert_kind_of(Array, @enum.partition{}[1])
  end

  test "partition returns expected results" do
    assert_equal([[1,3,5],[2,4]], @enum.partition{ |e| e % 2 != 0 })
    assert_equal([[1,2,3,4,5],[]], @enum.partition{ |e| e < 10 })
    assert_equal([[],[1,2,3,4,5]], @enum.partition{ |e| e > 10 })
  end

  test "partition where no elements match block conditions returns expected results" do
    assert_equal([[],[]], [].partition{ |e| e > 10 })
  end

  test "partition with explicit nil and false returns expected results" do
    assert_equal([[nil],[false]], [nil,false].partition{ |e| e.nil? })
    assert_equal([[false],[nil]], [nil,false].partition{ |e| e == false })
    assert_equal([[],[nil, false]], [nil,false].partition{})
  end

  test "partition with no arguments returns an Enumerator object" do
    assert_kind_of(Enumerator, @enum.partition)
  end

  test "partition does not accept any arguments" do
    assert_raise(ArgumentError){ @enum.partition(true) }
  end

  def teardown
    @enum = nil
  end
end
