######################################################################
# test_default_get.rb
#
# Tests for the Hash#default method.
######################################################################
require 'test/helper'
require 'test/unit'

class Test_Hash_DefaultGet_InstanceMethod < Test::Unit::TestCase
  def setup
    @hash1 = Hash.new
    @hash2 = Hash.new('test')
    @hash3 = Hash.new{ |h,k| h[k] = k.to_i * 3 }
  end

  test "default getter basic functionality" do
    assert_respond_to(@hash1, :default)
    assert_respond_to(@hash1, :default=)
  end

  test "default expected return values with no key argument" do
    assert_equal(nil, @hash1.default)
    assert_equal('test', @hash2.default)
    assert_equal(nil, @hash3.default)
  end

  test "default expected return values with key argument to block" do
    assert_equal(0, @hash3.default(nil))
    assert_equal(0, @hash3.default(0))
    assert_equal(9, @hash3.default(3))
  end

  test "default with key when no new block and no default returns nil" do
    assert_nil(@hash1.default(1))
  end

  test "default value with key argument with no constructor block" do
    assert_nil(@hash1.default(2))
    assert_equal("test", @hash2.default(2))
  end

  test "default accepts a maximum of one argument" do
    assert_raise(ArgumentError){ @hash1.default(1, 2) }
  end

  def teardown
    @hash1 = nil   
    @hash2 = nil
    @hash3 = nil
  end
end
