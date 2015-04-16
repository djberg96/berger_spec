###########################################################
# test_each_value.rb
#
# Test suite for the Hash#each_value instance method.
###########################################################
require 'test/helper'
require 'test/unit'

class TC_Hash_EachValue_InstanceMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @hash = Hash["ant", 1, "bat", 2, "cat", 3, "dog", 4]
  end

  test "each_value basic functionality" do
    assert_respond_to(@hash, :each_value)
    assert_nothing_raised{ @hash.each_value{} }
  end

  test "each_value iterates as expected" do
    i = 0
    @hash.each_value{ |key|
      assert_true([1,2,3,4].include?(key))
      i += 1
    }
    assert_equal(4, i)
  end

  test "calling each_value on an empty hash is a no-op" do
    i = 0
    {}.each_value{ i += 1 }
    assert_equal(0, i)
  end

  test "calling each_value with an empty block is a no-op" do
    assert_equal(@hash, @hash.each_value{})
  end

  test "each_value does not accept any arguments" do
    assert_raise(ArgumentError){ @hash.each_value(1){} }
  end

  test "each_value without a block behaves as expected" do
    assert_kind_of(Enumerator, @hash.each_value)
  end

  def teardown
    @hash = nil
  end
end
