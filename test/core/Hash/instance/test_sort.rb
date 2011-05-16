###########################################################
# test_sort.rb
#
# Tests for the Hash#sort instance method.
###########################################################
require 'test/helper'
require 'test/unit'

class TC_Hash_Sort_InstanceMethod < Test::Unit::TestCase
  def setup
    @hash = {'c', 3, 'a', 1, 'b', 2}
  end

  test "sort basic functionality" do
    assert_respond_to(@hash, :sort)
    assert_nothing_raised{ @hash.sort }
    assert_nothing_raised{ @hash.sort{ |a,b| a <=> b } }
    assert_kind_of(Array, @hash.sort)
  end

  test "sort expected results" do
    assert_equal([['a',1],['b',2],['c',3]], @hash.sort)
    assert_equal([], {}.sort)
  end

  test "sort with block expected results" do
    assert_equal([['c',3],['b',2],['a',1]], @hash.sort{ |a,b| b <=> a })
    assert_equal([['c',3],['b',2],['a',1]], @hash.sort{ 1 } )
    assert_equal([], {}.sort{ |a,b| b <=> a })
  end

  test "sort with block requires valid sorting value" do
    assert_raise(ArgumentError){ @hash.sort{} }
    assert_raise(NoMethodError){ @hash.sort{ true } }
  end

  def teardown
    @hash = nil
  end
end
