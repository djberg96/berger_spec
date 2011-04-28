######################################################################
# test_default.rb
#
# Test suite for the Hash#default instance method.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_Hash_Default_InstanceMethod < Test::Unit::TestCase
  #include Test::Helper

  def setup
    @hash1 = Hash.new
    @hash2 = Hash.new("test")
    @hash3 = Hash.new{ |h,k| h[k] = k.to_i * 3 }
  end

  test "default basic functionality" do
    assert_respond_to(@hash1, :default)
    assert_nothing_raised{ @hash1.default }
  end

  # Historical note: the default value for Hash.new{} was changed in Ruby 1.8.5
  test "default with no argument returns expected value" do
    assert_nil(@hash1.default)
    assert_equal("test", @hash2.default)
    assert_nil(@hash3.default)
  end

  test "default with key argument with no proc returns expected value" do
    assert_equal(nil, @hash1.default(2))
    assert_equal("test", @hash2.default(2))
  end

  test "default with key argument with proc returns expected value" do
    assert_equal(0, @hash3.default(nil))
    assert_equal(0, @hash3.default(0))
    assert_equal(9, @hash3.default(3))
    assert_equal(6, @hash3.default(2))
  end

  test "default accepts a maximum of one argument" do
    assert_raises(ArgumentError){ @hash1.default(1,2) }
  end

  def teardown
    @hash1 = nil
    @hash2 = nil
    @hash3 = nil
  end
end
