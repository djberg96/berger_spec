###########################################################
# test_fetch.rb
#
# Tests for the Hash#fetch instance method.
###########################################################
require 'test/helper'
require 'test/unit'

class TC_Hash_Fetch_InstanceMethod < Test::Unit::TestCase
  def setup
    @hash = {:foo, 1, "bar", 2, nil, 3, false, 4}
    @default = Hash.new(0)
  end

  test "fetch basic functionality" do
    assert_respond_to(@hash, :fetch)
    assert_nothing_raised{ @hash.fetch(:foo) }
    assert_nothing_raised{ @hash.fetch("test"){} }
  end

  test "fetch expected results" do
    assert_equal(1, @hash.fetch(:foo))
    assert_equal(2, @hash.fetch("bar"))
    assert_equal(3, @hash.fetch(nil))
    assert_equal(4, @hash.fetch(false))
  end

  test "fetch returns default value if key not found" do
    assert_equal('test', @hash.fetch(99, 'test'))
    assert_equal('test', @hash.fetch(true, 'test'))
  end

  test "fetch raises an IndexError if the key is not found" do
    assert_raise(IndexError){ @hash.fetch("bogus") }
    assert_raise(IndexError){ @hash.fetch(1) }
  end

  test "constructor default value is ignored if the key is not found" do
    assert_raise(IndexError){ @default.fetch(1) }
  end

  test "fetch requires at least one argument" do
    assert_raise(ArgumentError){ @hash.fetch }
  end

  test "fetch accepts a maximum of two arguments" do
    assert_raise(ArgumentError){ @hash.fetch('bar', false, nil) }
    assert_raise(ArgumentError){ @hash.fetch{} }
  end

  def teardown
    @hash = nil
    @default = nil
  end
end
