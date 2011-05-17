###########################################################
# test_each_key.rb
#
# Test suite for the Hash#each_key instance method.
###########################################################
require 'test/helper'
require 'test/unit'

class TC_Hash_EachKey_InstanceMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @hash = {'ant', 1, 'bat', 2, 'cat', 3, 'dog', 4}
  end

  test 'each_key basic functionality' do
    assert_respond_to(@hash, :each_key)
    assert_nothing_raised{ @hash.each_key{} }
  end

  test 'each_key iterates as expected' do
    i = 0
    @hash.each_key{ |key|
      assert_true(['ant','bat','cat','dog'].include?(key))
      i += 1
    }
    assert_equal(4, i)
  end

  test "calling each_key on an empty hash is a no-op" do
    i = 0
    {}.each_key{ i += 1 }
    assert_equal(0, i)
    assert_equal(@hash, @hash.each_key{})
  end

  test "each_key does not accept any arguments" do
    assert_raise(ArgumentError){ @hash.each_key(1){} }
  end

  test "each_key without a block behaves as expected" do
    if PRE187
      assert_raise(LocalJumpError){ @hash.each_key }
    else
      assert_kind_of(Enumerable::Enumerator, @hash.each_key)
    end
  end

  def teardown
    @hash = nil
  end
end
