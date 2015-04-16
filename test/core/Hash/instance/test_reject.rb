####################################################################
# test_reject.rb
#
# Test suite for the Hash#reject instance method.
####################################################################
require 'test/helper'
require 'test/unit'

class TC_Hash_Reject_InstanceMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @hash = Hash[:foo, 1, "bar", 2, nil, 3, false, 4]
  end

  test "reject basic functionality" do
    assert_respond_to(@hash, :reject)
    assert_nothing_raised{ @hash.reject{} }
    assert_nothing_raised{ @hash.reject!{} }
  end

  test "reject returns the expected results" do
    assert_equal(Hash[:foo, 1, "bar", 2], @hash.reject{ |k,v| v > 2 })
    assert_equal(@hash, @hash.reject{ |k,v| v > 5 })
    assert_equal({}, @hash.reject{ |k,v| v >= 0 })
  end

  test "reject handles explicit nil and false properly" do
    assert_equal({}, {1 => nil, 2 => nil}.reject{ |k,v| v.nil? })
    assert_equal({}, {1 => false, 2 => false}.reject{ |k,v| v == false })
  end

  test "reject without a block behaves as expected" do
    assert_kind_of(Enumerator, @hash.reject)
  end

  test "reject does not accept any arguments" do
    assert_raise(ArgumentError){ @hash.reject(1){} }
  end

  def teardown
    @hash = nil
  end
end
