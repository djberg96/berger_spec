###########################################################
# test_values_at.rb
#
# Test suite for the Hash#values_at instance method.
###########################################################
require 'test/helper'
require 'test-unit'

class Test_Hash_ValuesAt_InstanceMethod < Test::Unit::TestCase
  def setup
    @hash1 = Hash['a',1,'b',2,'c',3]
    @hash2 = Hash['a',1,'b',2,'c',3]
    @hash2.default = 7
  end

  test 'values_at basic functionality' do
    assert_respond_to(@hash1, :values_at)
    assert_nothing_raised{ @hash1.values_at('a') }
  end

  test 'values_at returns the expected results' do
    assert_equal([1], @hash1.values_at('a'))
    assert_equal([1,nil], @hash1.values_at('a','z'))
    assert_equal([1,2,3], @hash1.values_at('a','b','c'))
    assert_equal([nil], @hash1.values_at('z'))
  end

  test 'values_at with a default value returns the default if not found' do
    assert_equal([1], @hash2.values_at('a'))
    assert_equal([1,7], @hash2.values_at('a','z'))
    assert_equal([1,2,7], @hash2.values_at('a','b','z'))
    assert_equal([7], @hash2.values_at('z'))
  end

  test 'values_at with block uses block result if not found' do
    @hash1 = Hash.new{ |hash, key| hash[key] = 'test' }
    assert_equal(['test'], @hash1.values_at('z'))
    assert_equal(['test', 'test'], @hash1.values_at('x','z'))
  end

  test 'values_at works with explicit nil, true and false' do
    @hash1 = {nil => 1, true => 2, false => 3}
    assert_equal([1], @hash1.values_at(nil))
    assert_equal([2], @hash1.values_at(true))
    assert_equal([3], @hash1.values_at(false))
  end

  def teardown
    @hash1 = nil
    @hash2 = nil
  end
end
