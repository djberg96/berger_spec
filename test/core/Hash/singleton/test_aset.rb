###########################################################
# test_aset.rb
#
# Test suite for the Hash[] class method.
##########################################################
require 'test/helper'
require 'test/unit'

class TC_Hash_Aset_SingletonMethod < Test::Unit::TestCase
  test "aset with no arguments returns an empty hash" do
    assert_equal({}, Hash[])
  end

  test "aset with string keys works as expected" do
    assert_equal({'foo'=>1}, Hash['foo'=>1])
    assert_equal({'foo'=>1}, Hash['foo',1])
    assert_equal({'foo'=>1, 'bar'=>2}, Hash['foo'=>1, 'bar'=>2])
  end

  test "aset with symbol keys works as expected" do
    assert_equal({:foo=>1}, Hash[:foo=>1])
    assert_equal({:foo=>1}, Hash[:foo,1])
    assert_equal({:foo=>1, :bar=>2}, Hash[:foo=>1, :bar=>2])
  end

  test "aset with explicit nil or false keys works as expected" do
    assert_equal({nil => 1}, Hash[nil => 1])
    assert_equal({false => 1}, Hash[false => 1])
  end

  test "aset with nested hash works as expected" do
    assert_equal({:foo => {:bar => 1}}, Hash[:foo, {:bar => 1}])
  end

  test "aset requires an even number of arguments" do
    assert_raises(ArgumentError){ Hash['foo'] }
  end
end
