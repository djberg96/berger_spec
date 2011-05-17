############################################################
# test_invert.rb
#
# Test suite for the Hash#invert instance method.
############################################################
require 'test/helper'
require 'test/unit'

class TC_Hash_Invert_InstanceMethod < Test::Unit::TestCase
  def setup
    @hash = {:foo, 1, "bar", 2, nil, 3, false, 4}
  end

  test "invert basic functionality" do
    assert_respond_to(@hash, :invert)
    assert_nothing_raised{ @hash.invert }
    assert_kind_of(Hash, @hash.invert)
  end

  test "invert returns expected results" do
    assert_equal({1, :foo, 2, "bar", 3, nil, 4, false}, @hash.invert)
  end

  test "invert does not modify the receiver" do
    @hash.invert
    assert_equal({:foo, 1, "bar", 2, nil, 3, false, 4}, @hash)
  end

  test "calling invert on an empty hash return an empty hash" do
    assert_equal({}, {}.invert)
  end

  test "calling invert on a hash with multiple identical values only returns one of them" do
    assert_equal(1, {"a",1,"b",1,"c",1}.invert.size)
  end

  test "invert does not accept any arguments" do
    assert_raise(ArgumentError){ @hash.invert(1) }
  end

  def teardown
    @hash = nil
  end
end
