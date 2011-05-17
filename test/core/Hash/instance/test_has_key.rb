#####################################################################
# test_has_key.rb
#
# Tests for the Hash#has_key? instance method.
#####################################################################
require 'test/helper'
require 'test/unit'

class TC_Hash_HasKey_InstanceMethod < Test::Unit::TestCase
  def setup
    @hash = {:foo, 1, "bar", 2, nil, 3, false, 4}
  end

  test "has_key? basic functionality" do
    assert_respond_to(@hash, :has_key?)
    assert_nothing_raised{ @hash.has_key?(:foo) }
    assert_boolean(@hash.has_key?(1))
  end

  test "key? is an alias for has_key?" do
    assert_alias_method(@hash, :key?, :has_key?)
  end

  test "has_key? expected true values" do
    assert_true(@hash.has_key?(:foo))
    assert_true(@hash.has_key?("bar"))
    assert_true(@hash.has_key?(nil))
    assert_true(@hash.has_key?(false))
  end

  test "has_key? expected false values" do
    assert_false(@hash.has_key?(99))
    assert_false(@hash.has_key?(true))
    assert_false(@hash.has_key?(1.0))
    assert_false(@hash.has_key?(:bar))
  end

  test "has_key requires one argument only" do
    assert_raise(ArgumentError){ @hash.has_key? }
    assert_raise(ArgumentError){ @hash.has_key?(1,2) }
  end

  def teardown
    @hash = nil
  end
end
