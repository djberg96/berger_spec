###############################################################################
# test_aset.rb
#
# Test suite for the Hash#[]= instance method as well as the Hash#store alias.
###############################################################################
require 'test/helper'
require 'test/unit'

class TC_Hash_Aset_InstanceMethod < Test::Unit::TestCase
  def setup
    @hash = Hash["foo", 1, :bar, 2, nil, 3, false, 4]
  end

  test "aset basic functionality" do
    assert_respond_to(@hash, :[]=)
    assert_nothing_raised{ @hash["hello"] = "world" }
  end

  test "store is an alias for aset" do
    assert_respond_to(@hash, :store)
    assert_alias_method(@hash, :store, :[]=)
  end

  test "aset returns expected values" do
    assert_equal(5, @hash["baz"] = 5)
    assert_equal("test", @hash["baz"] = "test")
    assert_equal(nil, @hash[:test] = nil)
    assert_equal(false, @hash[:lala] = false)
    assert_equal([], @hash[:foo] = [])
  end

  test "aset allows a hash to store itself" do
    assert_nothing_raised{ @hash[:self] = @hash }
  end

  test "aset accepts only one argument" do
    assert_raise(ArgumentError){ @hash.send(:[]=, 1, 2, 3) }
  end

  def teardown
    @hash = nil
  end
end
