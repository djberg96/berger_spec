###########################################################
# test_select.rb
#
# Test suite for the Hash#select instance method.
###########################################################
require 'test/helper'
require 'test-unit'

class TC_Hash_Select_InstanceMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @hash = Hash["a", 1, "b", 2, "c", 3]
  end

  test "select basic functionality" do
    assert_respond_to(@hash, :select)
    assert_nothing_raised{ @hash.select{} }
    assert_kind_of(Hash, @hash.select{})
  end

  test "select returns expected results" do
    assert_equal(Hash["a",1,"b",2], @hash.select{ |k,v| v <=2 })
    assert_equal(Hash["a",1,"b",2,"c",3], @hash.select{ true })
    assert_equal({}, @hash.select{ false })
    assert_equal({}, @hash.select{ |k,v| v > 99 })
  end

  test "select behaves as expected if no block is provided" do
    assert_kind_of(Enumerator, @hash.select)
  end

  test "select does not accept any arguments" do
    assert_raise(ArgumentError){ @hash.select(1) }
  end

  def teardown
    @hash = nil
  end
end
