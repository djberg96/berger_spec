############################################################
# test_values.rb
#
# Test suite for the Hash#values instance method.
############################################################
require 'test/helper'
require 'test/unit'

class TC_Hash_Values_InstanceMethod < Test::Unit::TestCase
  def setup
    @hash = {'a', 1, 'b', 2, 'c', 3}
  end

  test 'values basic functionality' do
    assert_respond_to(@hash, :values)
    assert_nothing_raised{ @hash.values }
  end

  test 'values returns expected results' do
    assert_equal([1,2,3], @hash.values.sort)
    assert_equal([1,1,1], {'a',1,'b',1,'c',1}.values)
    assert_equal([nil], {1,nil}.values)
  end

  test 'values returns an empty array if the hash is empty' do
    assert_equal([], {}.values)
  end

  test 'values handles nested values as expected' do
    assert_equal([{'foo' => 2}], {1, {'foo' => 2}}.values)
    assert_equal([{nil => 1, false => 2}], {1, {nil => 1, false => 2}}.values)
  end

  test 'values does not accept any arguments' do
    assert_raise(ArgumentError){ @hash.values(1) }
  end

  def teardown
    @hash = nil
  end
end
