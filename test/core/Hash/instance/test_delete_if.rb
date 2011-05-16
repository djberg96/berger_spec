###########################################################
# test_delete_if.rb
#
# Test suite for the Hash#delete_if instance method.
###########################################################
require 'test/helper'
require 'test/unit'

class TC_Hash_DeleteIf_InstanceMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @hash = {:foo, 1, "bar", 2, nil, 3, false, 4}
  end

  test "delete_if basic functionality" do
    assert_respond_to(@hash, :delete_if)
    assert_nothing_raised{ @hash.delete_if{} }
  end

  test "delete_if returns the expected results" do
    assert_equal({:foo, 1, "bar", 2}, @hash.delete_if{ |k,v| v > 2 })
    assert_equal({:foo, 1, "bar", 2}, @hash.delete_if{ |k,v| v > 5 })
  end

  test "delete_if returns an empty hash if the proc conditions are not met" do
    assert_equal({}, @hash.delete_if{ |k,v| v >= 0 })
  end

  test "delete_if with no block behaves as expected" do
    if PRE187
      assert_raise(LocalJumpError){ @hash.delete_if }
    else
      assert_kind_of(Enumerable::Enumerator, @hash.delete_if)
    end
  end

  test "delete_if does not accept any arguments" do
    assert_raise(ArgumentError){ @hash.delete_if(1){} }
  end

  def teardown
    @hash = nil
  end
end
