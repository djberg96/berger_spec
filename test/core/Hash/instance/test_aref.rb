#######################################################################
# test_aref.rb
#
# Tests for the Hash#[] instance method.
#######################################################################
require 'test/helper'
require 'test/unit'

class Test_Hash_Aref_InstanceMethod < Test::Unit::TestCase
  def setup
    @hash = Hash[:foo, 1, 'bar', 2, nil, 3, false, 4, 'foo', 5, 3.7, 6.0]
  end

  test "aref basic functionality" do
    assert_respond_to(@hash, :[])
    assert_nothing_raised{ @hash['bar'] }
  end

  test "aref expected results" do
    assert_equal(1, @hash[:foo])
    assert_equal(2, @hash['bar'])
    assert_equal(5, @hash['foo'])
    assert_equal(nil, @hash['bogus'])
  end

  test "aref with explicit nil key works as expected" do
    assert_equal(3, @hash[nil])
  end

  test "aref with explicit false key works as expected" do
    assert_equal(4, @hash[false])
  end

  test "aref with float works as expected" do
    assert_equal(6.0, @hash[3.7])
  end

  test "aref with nested hash returns expected result" do
    hash = Hash[{:a => 1}, {:b => 2}]
    assert_equal({:b => 2}, hash[{:a => 1}])
  end

  test "aref requires at least on argument" do
    assert_raise(ArgumentError){ @hash[] }
  end

  def teardown
    @hash = nil
  end
end
