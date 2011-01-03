#########################################################################
# test_collect_bang.rb
#
# Test suite for the Array#collect! instance method.
#########################################################################
require 'test/helper'
require 'test/unit'

class Test_Array_Collect_Bang_InstanceMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @array = [1, 2, 3] 
  end

  test 'collect_bang basic functionality' do
    assert_respond_to(@array, :collect!)
    assert_nothing_raised{ @array.collect!{} }
  end

  test 'collect_bang returns expected results' do
    assert_equal([2, 3, 4], @array.collect!{ |e| e += 1 })
    assert_equal(["\001", "\002", "\003"], [1, 2, 3].collect!{ |e| e.chr })
  end

  test 'collect_bang modifies its receiver' do
    assert_equal([2, 3, 4], @array.collect!{ |e| e += 1 })
    assert_equal([2, 3, 4], @array)
  end

  test "collect_bang is an alias for map_bang" do
    assert_respond_to(@array, :map!)
    assert_alias_method(@array, :collect!, :map!)
  end

  test 'collect_bang exhibits the expected behavior if no block is provided' do
    if PRE187
      assert_raise(LocalJumpError){ @array.collect! }
    else
      assert_kind_of(Enumerable::Enumerator, @array.collect!)
      assert_equal(3, @array.collect!.count)
    end
  end

  test 'an error is raised if the wrong number of arguments are provided' do
    assert_raise(ArgumentError){ @array.collect!(5) }
  end

  test 'passing an empty block converts all elements to nil' do
    assert_equal([nil, nil, nil], @array.collect!{ })
    assert_equal([nil, nil, nil], @array.collect!{ |e| })
  end

  test 'passing a value to the block converts all elements to that value' do
    assert_equal([7, 7, 7], @array.collect!{ 7 })
    assert_equal(['a', 'a', 'a'], @array.collect!{ 'a' })
  end

=begin
  # THIS BEHAVIOR IS UNDEFINED
 
  test 'individual elements are modified during iteration' do
    assert_equal([3, 2], @array.collect!{ |e| @array.pop })
  end

  test 'elements are removed before they are reached' do
    assert_equal([2, 3], @array.collect!{ |e| @array.delete(@array[1]) })
  end
=end

  test 'elements can be set to nil during iteration' do
    assert_equal([nil, nil, nil], @array.collect!{ |e| @array = nil } )
  end

  test 'clearing an array during iteration results in ambiguous array' do
    assert_equal("[...]", @array.collect!{ |e| @array.clear }.to_s )
  end

  def teardown
    @array = nil
  end
end
