################################################################
# test_new.rb
#
# Test suite for the Hash.new class method.
################################################################
require 'test/helper'
require 'test/unit'

class TC_Hash_New_SingletonMethod < Test::Unit::TestCase
  def setup
    @hash = nil
  end

  test "new basic functionality" do
    assert_respond_to(Hash, :new)
    assert_nothing_raised{ Hash.new }
    assert_kind_of(Hash, Hash.new)
  end

  test "new accepts a default value" do
    assert_nothing_raised{ Hash.new("test") }
    assert_nothing_raised{ Hash.new(0) }
    assert_nothing_raised{ Hash.new(nil) }
    assert_nothing_raised{ Hash.new(false) }
  end

  test "the default value passed to new is returned if the key is not found" do
    @hash = Hash.new('test')
    assert_equal('test', @hash['foo'])
    assert_equal('test', @hash['bar'])
  end

  test "new accepts a block" do
    assert_nothing_raised{ Hash.new{ } }
    assert_nothing_raised{ Hash.new{ |hash, key| } }
  end

  test "the value of the block passed to new is returned if the key is not found" do
    @hash = Hash.new{ |h,k| h[k] = 'test' }
    assert_equal('test', @hash['foo'])
    assert_equal('test', @hash['bar'])
  end

  test "new accepts a maximum of one argument" do
    assert_raise(ArgumentError){ Hash.new(1,2) }
  end

  test "new does not accept both an argument and a block" do
    assert_raise(ArgumentError){ Hash.new(0){ } }
  end

  def teardown
    @hash = nil
  end
end
