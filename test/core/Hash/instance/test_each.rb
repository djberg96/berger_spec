##############################################################################
# test_each.rb
#
# Test suite for the Hash#each instance method and the Hash#each_pair alias.
##############################################################################
require 'test/helper'
require 'test/unit'

class TC_Hash_Each_InstanceMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @hash = Hash["ant", 1, "bat", 2, "cat", 3, "dog", 4]
    @int  = 0
  end

  test "each basic functionality" do
    assert_respond_to(@hash, :each)
    assert_nothing_raised{ @hash.each{} }
  end

  test "each iterates as expected" do
    @hash.each{ |key, value|
      assert_equal(value, @hash.delete(key))
      @int += 1
    }
    assert_equal(4, @int)
  end

  test "calling each on an empty hash is a no-op" do
    {}.each{ @int += 1 }
    assert_equal(0, @int)
  end

  test "calling each with an empty block is a no-op" do
    assert_equal(@hash, @hash.each{})
  end

  test "each_pair is an alias for each" do
    assert_respond_to(@hash, :each_pair)
    assert_alias_method(@hash, :each, :each_pair)
  end

  test "each does not accept any arguments" do
    assert_raise(ArgumentError){ @hash.each(1){} }
  end

  test "each with no block behaves as expected" do
    assert_kind_of(Enumerator, @hash.each)
  end

  def teardown
    @hash = nil
    @int  = nil
  end
end
