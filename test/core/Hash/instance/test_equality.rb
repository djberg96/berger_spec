###########################################################
# test_equality.rb
#
# Tests for the Hash#== instance method.
###########################################################
require 'test/helper'
require 'test/unit'

class TC_Hash_Equality_InstanceMethod < Test::Unit::TestCase
  class HEquality
    def to_hash
      {'foo' => 1, 'bar' => 2}
    end
  end

  def setup
    @hash1  = {"foo"=>1, "bar"=>2}
    @hash2  = {"bar"=>2, "foo"=>1}
    @hash3  = {:foo=>1, :bar=>2}
    @custom = HEquality.new
  end

  test "equality basic functionality" do
    assert_respond_to(@hash1, :==)
    assert_nothing_raised{ @hash1 == @hash2 }
    assert_boolean(@hash1 == @hash2)
  end

  test "a hash is always equal to itself" do
    assert_true(@hash1 == @hash1)
  end

  test "a hash is equal to another hash if they have same keys and values" do
    assert_true(@hash1 == @hash2)
  end

  test "an empty hash is equal to another empty hash" do
    assert_true({} == {})
  end

  test "symbols and strings are not considered equal" do
    assert_false(@hash1 == @hash3)
  end

  test "false and nil and true are not equal" do
    assert_false({nil=>1} == {false=>1})
    assert_false({true=>1} == {false=>1})
  end

  test "nil and zero are not equal" do
    assert_false({nil=>1} == {0=>1})
  end

  test "custom to_hash method is honored when determining equality" do
    assert_true(@hash1 == @custom)
    assert_false({1,2} == @custom)
  end

  def teardown
    @hash1  = nil
    @hash2  = nil
    @hash3  = nil
    @custom = nil
  end
end
