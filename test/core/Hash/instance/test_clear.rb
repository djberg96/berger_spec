###########################################################
# test_clear.rb
#
# Test suite for the Hash#clear instance method.
###########################################################
require 'test/helper'
require 'test-unit'

class Test_Hash_Clear_InstanceMethod < Test::Unit::TestCase
  def setup
    @hash  = Hash["foo"=>1, :bar=>2]
    @empty = {}
  end

  test "clear basic functionality" do
    assert_respond_to(@hash, :clear)
    assert_nothing_raised{ @hash.clear }
  end

  test "clear returns an empty hash" do
    assert_equal({}, @hash.clear)
    assert_equal({}, {{:foo=>1,:bar=>2}=>3, {:baz=>4,:blah=>5}=>6}.clear)
  end

  test "clear modifies the receiver" do
    assert_equal({}, @hash.clear)
    assert_equal({}, @hash)
  end

  test "clear works on an empty hash" do
    assert_equal({}, @empty.clear)
  end

  test "clear works on a hash containing nil keys or values" do
    assert_equal({}, {nil => 1}.clear)
    assert_equal({}, {1 => nil}.clear)
  end

  test "clear does not return new object" do
    assert_equal(@hash.object_id, @hash.clear.object_id)
    assert_equal(@empty.object_id, @empty.clear.object_id)
  end

  test "clear does not accept any arguments" do
    assert_raise(ArgumentError){ @hash.clear(1) }
  end

  def teardown
    @hash  = nil
    @empty = nil
  end
end
