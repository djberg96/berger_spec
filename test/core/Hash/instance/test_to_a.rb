############################################################
# test_to_a.rb
#
# Test suite for the Hash#to_a instance method.
############################################################
require 'test/helper'
require 'test-unit'

class TC_Hash_ToA_InstanceMethod < Test::Unit::TestCase
  def setup
    @hash = Hash["a",1,"b",2,"c",3]
  end

  test "to_a basic functionality" do
    assert_respond_to(@hash, :to_a)
    assert_nothing_raised{ @hash.to_a }
    assert_kind_of(Array, @hash.to_a)
  end

  test "to_a returns expected results" do
    assert_equal([["a",1],["b",2],["c",3]], @hash.to_a)
    assert_equal([['a', [1,2]], ['b', [3,4]]], Hash['a', [1,2], 'b', [3,4]].to_a)
    assert_equal([], {}.to_a)
  end

  test "a hash with identical keys returns the expected result" do
    assert_equal([['a', 3]], Hash['a', 1, 'a', 2, 'a', 3].to_a)
  end

  test "a hash of nil or false keys and values returns the expected result" do
    assert_equal([[nil, nil]], Hash[nil, nil, nil, nil].to_a)
    assert_equal([[false, false]], Hash[false, false, false, false].to_a)
  end

  test "to_a does not accept any arguments" do
    assert_raise(ArgumentError){ @hash.to_a(1) }
  end

  def teardown
    @hash = nil
  end
end
