############################################################################
# test_length.rb
#
# Test suite for the Hash#length instance method and the Hash#size alias.
############################################################################
require 'test/helper'
require 'test/unit'

class TC_Hash_Length_InstanceMethod < Test::Unit::TestCase
  def setup
    @hash = {"a", 1, "b", 2, "c", 3}
  end

  test "length basic functionality" do
    assert_respond_to(@hash, :length)
    assert_nothing_raised{ @hash.length }
    assert_kind_of(Numeric, @hash.length)
  end

  test "length returns expected results" do
    assert_equal(3, @hash.length)
    assert_equal(1, {"a",1,"a",2}.length)
    assert_equal(0, {}.length)
  end

  test "length returns expected results for hashes with multiple identical keys" do
    assert_equal(1, {'a', 1, 'a', 2, 'a', 3}.length)
    assert_equal(1, {nil,nil}.length)
    assert_equal(1, {true, true, true, true}.length)
  end

  test "size is an alias for length" do
    assert_respond_to(@hash, :size)
    assert_alias_method(@hash, :size, :length)
  end

  test "length does not accept any arguments" do
    assert_raise(ArgumentError){ @hash.length(1) }
  end

  def teardown
    @hash = nil
  end
end
