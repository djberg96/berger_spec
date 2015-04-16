###############################################################################
# test_has_value.rb
#
# Tests for the Hash#has_value? instance method.
###############################################################################
require 'test/helper'
require 'test/unit'

class TC_Hash_HasValue_InstanceMethod < Test::Unit::TestCase
  def setup
    @hash = Hash[:foo, 1, "bar", 2, nil, 3, false, 4]
  end

  test "has_value? basic functionality" do
    assert_respond_to(@hash, :has_value?)
    assert_nothing_raised{ @hash.has_value?(1) }
    assert_boolean(@hash.has_value?(1))
  end

  test "has_value? expected true results" do
    assert_true(@hash.has_value?(1))
    assert_true(@hash.has_value?(2))
    assert_true(@hash.has_value?(3))
    assert_true(@hash.has_value?(4))
  end

  test "has_value? expected false results" do
    assert_false(@hash.has_value?(99))
    assert_false(@hash.has_value?(false))
    assert_false(@hash.has_value?(nil))
  end

  test "value? is an alias for has_value?" do
    assert_alias_method(@hash, :value?, :has_value?)
  end

  test "has_value? requires one argument only" do
    assert_raise(ArgumentError){ @hash.has_value? }
    assert_raise(ArgumentError){ @hash.has_value?(1,2) }
  end

  def teardown
    @hash = nil
  end
end
