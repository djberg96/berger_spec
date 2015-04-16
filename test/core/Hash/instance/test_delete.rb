###########################################################
# test_delete.rb
#
# Test suite for the Hash#delete instance method.
###########################################################
require 'test/helper'
require 'test-unit'

class TC_Hash_Delete_InstanceMethod < Test::Unit::TestCase
  def setup
    @hash = Hash[:a, 1, :b, true, :c, false, :d, nil]
  end

  test "delete basic functionality" do
    assert_respond_to(@hash, :delete)
    assert_nothing_raised{ @hash.delete(:a) }
  end

  test "delete returns expected values" do
    assert_equal(1, @hash.delete(:a))
    assert_equal(true, @hash.delete(:b))
    assert_equal(false, @hash.delete(:c))
    assert_equal(nil, @hash.delete(:d))
  end

  test "delete returns nil if key is not found" do
    assert_equal(nil, @hash.delete(:f))
  end

  test "delete returns block value if key is not found" do
    assert_equal(1, @hash.delete(:a){ 99 })
    assert_equal(99, @hash.delete(:f){ 99 })
  end

  test "delete requires one argument only" do
    assert_raise(ArgumentError){ @hash.delete }
    assert_raise(ArgumentError){ @hash.delete(1,2) }
  end

  def teardown
    @hash = nil
  end
end
