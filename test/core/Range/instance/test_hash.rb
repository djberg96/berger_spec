######################################################################
# tc_hash.rb
#
# Test case for the Range#hash instance method.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_Range_Hash_InstanceMethod < Test::Unit::TestCase
  def setup
    @range1 = Range.new(1, 100)
    @range2 = Range.new('a', 'z', true)
  end

  test "hash basic functionality" do
    assert_respond_to(@range1, :hash)
    assert_nothing_raised{ @range1.hash }
    assert_kind_of(Numeric, @range1.hash)
  end

  test "range equality works as expected" do
    assert_true(@range1.hash == Range.new(1, 100).hash)
    assert_false(@range1.hash == Range.new(1, 99).hash)
    assert_false(@range1.hash == Range.new(1.0, 100).hash)
  end

  test "a subset of a range is not considered equal" do
    assert_true(@range2.hash == Range.new('a', 'z', true).hash)
    assert_false(@range2.hash == Range.new('a', 'z').hash)
  end

  test "hash does not accept any arguments" do
    assert_raise(ArgumentError){ @range1.hash(1) }
    assert_raise(ArgumentError){ @range1.send(:hash, 1) }
  end

  def teardown
    @range1 = nil
    @range2 = nil
  end
end
