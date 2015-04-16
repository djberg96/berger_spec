####################################################################
# test_reject_bang.rb
#
# Test suite for the Hash#reject! instance method.
####################################################################
require 'test/helper'
require 'test-unit'

class TC_Hash_RejectBang_InstanceMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @hash = Hash[:foo, 1, "bar", 2, nil, 3, false, 4]
  end

  test "reject_bang basic functionality" do
    assert_respond_to(@hash, :reject!)
    assert_nothing_raised{ @hash.reject!{} }
  end

  test "reject_bang returns the expected results" do
    assert_equal(Hash[:foo, 1, "bar", 2], @hash.reject!{ |k,v| v > 2 })
    assert_nil(@hash.reject!{ |k,v| v > 5 })
    assert_nil(@hash.reject!{})
  end

  test "reject_bang without a block behaves as expected" do
    assert_kind_of(Enumerator, @hash.reject!)
  end

  test "reject_bang does not accept any arguments" do
    assert_raise(ArgumentError){ @hash.reject!(1){} }
  end

  def teardown
    @hash = nil
  end
end
