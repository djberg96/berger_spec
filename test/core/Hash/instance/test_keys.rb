############################################################
# test_keys.rb
#
# Test suite for the Hash#keys instance method.
############################################################
require 'test/helper'
require 'test/unit'

class TC_Hash_Keys_InstanceMethod < Test::Unit::TestCase
  def setup
    @hash = {"a", 1, "b", 2, "c", 3}
  end

  test "keys basic functionality" do
    assert_respond_to(@hash, :keys)
    assert_nothing_raised{ @hash.keys }
    assert_kind_of(Array, @hash.keys)
  end

  test "keys returns the expected results" do
    assert_equal(["a", "b", "c"], @hash.keys.sort)
    assert_equal(["a"], {"a",1,"a",2,"a",3}.keys)
    assert_equal([nil], {nil,1}.keys)
    assert_equal([false], {false,1}.keys)
  end

  test "calling keys on an empty hash returns an empty array" do
    assert_equal([], {}.keys)
  end

  test "keys does not accept any arguments" do
    assert_raise(ArgumentError){ @hash.keys(1) }
  end

  def teardown
    @hash = nil
  end
end
