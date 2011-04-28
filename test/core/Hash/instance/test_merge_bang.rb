###########################################################################
# test_merge_bang.rb
#
# Test suite for the Hash#merge! instance method.
###########################################################################
require 'test/helper'
require 'test/unit'

class Test_Hash_Merge_Bang_InstanceMethod < Test::Unit::TestCase
  def setup
    @hash1 = {"a", 1, "b", 2}
    @hash2 = {"c", 3, "d", 4}
  end

  test "merge_bang basic functionality" do
    assert_respond_to(@hash1, :merge!)
    assert_nothing_raised{ @hash1.merge!(@hash2) }
    assert_kind_of(Hash, @hash1.merge!(@hash2))
  end
   
  test "merge_bang expected results" do
    assert_equal({"a",1,"b",2,"c",3,"d",4}, @hash1.merge!(@hash2))
    assert_equal({"a",1,"b",2,"c",3,"d",4}, @hash1.merge!({}))
    assert_equal({"a",1,"b",2,"c",3,"d",4}, @hash1.merge!({"a",1}))
    assert_equal({"a", 1, "b", 2, "c", 3, "d", 4}, @hash1)
    assert_equal({"c", 3, "d", 4}, @hash2)
  end
   
  test "merge_bang with block expected results" do
    assert_equal({"a",1,"b",2,"c",3,"d",4}, @hash1.merge!(@hash2){|k,o,n| o })
    assert_equal({"a",1,"b",2,"c",3,"d",4}, @hash1)
    assert_equal({"a",4,"b",2}, {"a",1,"b",2}.merge!({"a",4}){ |k,o,n| n })
    assert_equal({"a",1,"b",2}, {"a",1,"b",2}.merge!({"a",4}){ |k,o,n| o })
    assert_equal({"c", 3, "d", 4}, @hash2)
  end

  test "update is an alias for merge_bang" do
    assert_alias_method(@hash1, :update, :merge!)
  end

  test "merging an empty hash returns an empty hash" do
    assert_equal({}, {}.merge!({}))
  end

  test "a hash merging itself returns itself" do
    id = @hash1.object_id
    assert_equal(@hash1, @hash1.merge!(@hash1))
    assert_equal(id, @hash1.object_id)
  end
   
  test "merge_bang requires a Hash argument" do
    assert_raise(TypeError){ @hash1.merge!("foo") }
    assert_raise(TypeError){ @hash1.merge!(1) }
    assert_raise(TypeError){ @hash1.merge!([]) }
  end

  test "merge_bang fails on a frozen hash" do
    assert_raise(TypeError){ @hash1.freeze.merge!(@hash2) }
  end
  
  def teardown
    @hash1 = nil
    @hash2 = nil
  end
end
