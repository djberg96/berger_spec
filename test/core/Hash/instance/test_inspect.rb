###############################################################################
# test_inspect.rb
#
# Test case for the Hash#inspect instance method. There's a custom inspect
# implementation in hash.c, so that's what we test it instead of relying on
# the tests for Object#inspect.
###############################################################################
require 'test/helper'
require 'test-unit'

class TC_Hash_Inspect_InstanceMethod < Test::Unit::TestCase
  def setup
    @empty     = {}
    @normal    = Hash[1, 'a', 2, 'b']
    @recursive = {1 => 'a'}
    @recursive[@recursive] = 2
    @recursive[3] = @recursive
  end

  test "inspect basic functionality" do
    assert_respond_to(@empty, :inspect)
    assert_nothing_raised{ @empty.inspect }
    assert_kind_of(String, @empty.inspect)
  end

  test "inspect on an empty hash returns the expected result" do
    assert_equal('{}', @empty.inspect)
  end

  test "inspect on a simple hash returns the expected result" do
    assert_equal('{1=>"a", 2=>"b"}', @normal.inspect)
  end

  # There's no way to sort this, so we'll check for any
  test "inspect on a recursive hash returns the expected result" do
    possible = [
      '{1=>"a", {...}=>2, 3=>{...}}',
      '{1=>"a", 3=>{...}, {...}=>2}',
      '{3=>{...}, {...}=>2, 1=>"a"}',
      '{3=>{...}, 1=>"a", {...}=>2}',
      '{{...}=>2, 3=>{...}, 1=>"a"}',
      '{{...}=>2, 1=>"a", 3=>{...}}',
    ]
    assert_true(possible.include?(@recursive.inspect))
  end

  test "inspect does not accept any arguments" do
    assert_raise(ArgumentError){ @normal.inspect(true) }
  end

  def teardown
    @empty     = nil
    @normal    = nil
    @recursive = nil
  end
end
