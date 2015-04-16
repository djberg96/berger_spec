###########################################################################
# test_merge.rb
#
# Test suite for the Hash#merge instance method. Tests for the Hash#merge!
# method can be found in the test_merge_bang.rb file.
###########################################################################
require 'test/helper'
require 'test-unit'

class TC_Hash_Merge_InstanceMethod < Test::Unit::TestCase
  def setup
    @hash1 = {"a" => 1, "b" => 2}
    @hash2 = {"c" => 3, "d" => 4}
  end

  test "merge basic functionality" do
    assert_respond_to(@hash1, :merge)
    assert_nothing_raised{ @hash1.merge(@hash2) }
    assert_kind_of(Hash, @hash1.merge(@hash2))
  end

  test "merge returns the expected results" do
    assert_equal(Hash["a",1,"b",2,"c",3,"d",4], @hash1.merge(@hash2))
    assert_equal(Hash["a",1,"b",2], @hash1.merge({}))
    assert_equal(Hash["b",2,"a",4], @hash1.merge({"a" => 4}))
    assert_equal(Hash["a",1,"b",2,nil,1], @hash1.merge({nil => 1}))
  end

  test "merge does not modify the receiver" do
    @hash1.merge(@hash2)
    assert_equal(Hash["a", 1, "b", 2], @hash1)
  end

  test "merge with a block returns the expected results" do
    assert_equal(Hash["a",1,"b",2,"c",3,"d",4], @hash1.merge(@hash2){|k,o,n| o })
    assert_equal(Hash["a",4,"b",2], @hash1.merge({"a" => 4}){ |k,o,n| n })
    assert_equal(Hash["a",1,"b",2], @hash1.merge({"a" => 4}){ |k,o,n| o })
  end

  test "merge with a block does not modify the receiver" do
    @hash1.merge(@hash2)
    assert_equal(Hash["a", 1, "b", 2], @hash1)
  end

  test "merging an empty hash with an empty hash returns an empty hash" do
    assert_equal({}, {}.merge({}))
  end

  test "merging a non-empty hash with an empty hash returns the non-empty hash" do
    assert_equal({1 => 2}, {1 => 2}.merge({}))
  end

  test "merge requires a hash argument" do
    assert_raise(TypeError){ @hash1.merge("foo") }
    assert_raise(TypeError){ @hash1.merge(1) }
    assert_raise(TypeError){ @hash1.merge([]) }
  end

  test "merge requires one argument only" do
    assert_raise(ArgumentError){ @hash1.merge }
    assert_raise(ArgumentError){ @hash1.merge({}, {}) }
  end

  def teardown
    @hash1 = nil
    @hash2 = nil
  end
end
