######################################################################
# test_to_s.rb
#
# Test case for the Range#to_s instance method. I've added this as a
# separate test because range.c has a custom implementation.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_Range_ToS_InstanceMethod < Test::Unit::TestCase
  def setup
    @range1 = Range.new(0, 1, false)
    @range2 = Range.new(0, 1, true)
  end

  test "to_s basic functionality" do
    assert_respond_to(@range1, :to_s)
    assert_nothing_raised{ @range1.to_s }
  end

  test "to_s returns expected results" do
    assert_equal('0..1', @range1.to_s)
    assert_equal('0...1', @range2.to_s)
    assert_equal('0..0', Range.new(0, 0).to_s)
    assert_equal('0...0', Range.new(0, 0, true).to_s)
  end

  test "to_s with empty arguments returns expected result" do
    assert_equal('..', Range.new('', '').to_s)
    assert_equal('[]..[]', Range.new([], []).to_s)
    assert_equal('{}..{}', Range.new({}, {}).to_s)
  end

  test "to_s with one empty argument returns expected result" do
    assert_equal('[]..[1]', Range.new([], [1]).to_s)
    assert_equal('[1]..[]', Range.new([1], []).to_s)
  end

  test "to_s does not accept any arguments" do
    assert_raises(ArgumentError){ @range1.to_s(0) }
  end

  def teardown
    @range1 = nil
    @range2 = nil
  end
end
