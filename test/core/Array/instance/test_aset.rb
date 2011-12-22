###############################################################################
# test_aset.rb
#
# Test suite for the Array#[]= instance method.
###############################################################################
require 'test/unit'

class Test_Array_Aset_InstanceMethod < Test::Unit::TestCase
  def setup
    @empty = []
    @basic = [1, 2, 3, 4, 5]
  end

  test 'aset basic functionality' do
    assert_respond_to(@basic, :[]=)
    assert_nothing_raised{ @basic[0] = 1 }
    assert_kind_of(String, @basic[1] = 'a')
  end
   
  test 'an integer index works as expected' do
    assert_nothing_raised{ @empty[0] = 'foo' }
    assert_equal('foo', @empty[0])
  end

  test 'aset returns the object assigned' do
    assert_equal('test', @empty[0] = 'test')
    assert_equal(nil, @empty[0] = nil)
    assert_equal(true, @empty[0] = true)
    assert_equal(false, @empty[0] = false)
    assert_equal(1, @empty[-1] = 1)
  end

  test 'a float index works as expected' do
    assert_nothing_raised{ @empty[0.5] = 'foo' }
    assert_equal('foo', @empty[0])
  end

  test 'a negative index within the array bounds is valid' do
    assert_nothing_raised{ @empty[0] = 'foo' }
    assert_nothing_raised{ @empty[-1] = 'foo' }
  end

  test 'if the index is greater than the current array size then it grows automatically' do 
    assert_nothing_raised(IndexError){ @empty[2] = 'foo' }
    assert_equal([nil, nil, 'foo'], @empty)
  end

  test 'aset with start and length basic functionality' do
    assert_nothing_raised{ @basic[0, 3] = 1 }
    assert_nothing_raised{ @basic[0, 3] = 1, 2 }
    assert_nothing_raised{ @basic[0, 3] = 1, 2, 3 }
    assert_nothing_raised{ @basic[0, 3] = 1, 2, 3, 4 }
  end

  test 'aset with number of elements equal to length' do
    assert_nothing_raised{ @basic[0, 2] = ['a', 'b'] }
    assert_equal(['a', 'b', 3, 4, 5], @basic)
  end

  test 'aset with number of elements less than length' do
    assert_nothing_raised{ @basic[0, 2] = 'a' }
    assert_equal(['a', 3, 4, 5], @basic)
  end

  test 'aset with number of elements greater than length' do
    assert_nothing_raised{ @basic[0, 2] = 'a', 'b', 'c', 'd' }
    assert_equal(['a', 'b', 'c', 'd', 3, 4, 5], @basic)
  end

  test 'using a length greater than array splices the array' do
    assert_nothing_raised{ @basic[0, 10] = 'x', 'y', 'z' }
    assert_equal(['x', 'y', 'z'], @basic)
  end

  test 'aset with start and length using array assignment' do
    assert_nothing_raised{ @basic[0, 3] = ['a', 'b', 'c'] }
    assert_equal(['a', 'b', 'c', 4, 5], @basic)
  end

  test 'aset with start and length using array splat assignment' do
    assert_nothing_raised{ @basic[0, 3] = *['a', 'b', 'c'] }
    assert_equal(['a', 'b', 'c', 4, 5], @basic)
  end

  test 'a float starting index and integer length is legal' do
    assert_nothing_raised{ @basic[0.5, 3] = ['a', 'b', 'c'] }
    assert_equal(['a', 'b', 'c', 4, 5], @basic)
  end 

  test 'a float starting index and float length is legal' do
    assert_nothing_raised{ @basic[0.5, 3.1] = ['a', 'b', 'c'] }
    assert_equal(['a', 'b', 'c', 4, 5], @basic)
  end

  test 'a negative float starting index and integer length is legal' do
    assert_nothing_raised{ @basic[-0.5, 3] = ['a', 'b', 'c'] }
    assert_equal(['a', 'b', 'c', 4, 5], @basic)
  end 

  test 'aset with range basic functionality' do
    assert_nothing_raised{ @basic[0..3] = 1 }
    assert_equal([1, 5], @basic)
  end

  test 'aset with range using array assignment works as expected' do
    assert_nothing_raised{ @basic[0..2] = ['a', 'b', 'c'] }
    assert_equal(['a', 'b', 'c', 4, 5], @basic)
  end

  test 'aset with splat array assignment works as expected' do
    assert_nothing_raised{ @basic[0..2] = ['a', 'b', 'c'] }
    assert_equal(['a', 'b', 'c', 4, 5], @basic)
  end

  test 'using a range larger than array does not make the array grow' do
    assert_nothing_raised{ @basic[4..10] = 1 }
    assert_equal([1, 2, 3, 4, 1], @basic)
  end

  test 'using a negative range with single assignment works as expected' do
    assert_nothing_raised{ @basic[-1..4] = 'x' }
    assert_equal([1, 2, 3, 4, 'x'], @basic)
  end

  test 'using a negative range with array assignment works as expected' do
    assert_nothing_raised{ @basic[-1..1] = ['a', 'b', 'c'] }
    assert_equal([1, 2, 3, 4, 'a', 'b', 'c', 5], @basic)
  end

  test 'using a length of zero inserts the object' do
    assert_nothing_raised{ @basic[1, 0] = 'a', 'b' }
    assert_equal([1, 'a', 'b', 2, 3, 4, 5], @basic)
  end

  test 'assigning nil in the second form deletes elements from the array' do
    assert_nothing_raised{ @basic[2, 1] = nil }
    assert_equal([1, 2, 4, 5], @basic)
  end

  test 'assigning nil in the third form deletes elements from the array' do
    assert_nothing_raised{ @basic[2..-2] = nil }
    assert_equal([1, 2, 5], @basic)
  end

  test 'a negative index that points past the beginning of the array raises an error' do
    assert_raise(IndexError){ @empty[-1] = 'foo' }
  end

  test 'an error is raised if a negative length is used' do
    assert_raise(IndexError){ @basic[1, -1] = 'x' }
  end

  test 'an error is raised if an invalid index type is used' do
    assert_raise(TypeError){ @basic['a'] = 1 }
  end

  test 'an error is raised if an invalid length type is used' do
    assert_raise(TypeError){ @basic[1, 'a'] = 1 }
  end

  test 'using a symbol as an index raises an error' do
    assert_raise(TypeError){ @basic['1'.to_sym, 0] = 10 }
    assert_raise(TypeError){ @basic[0, '1'.to_sym] = 10 }
  end

  test 'using a symbol as an index raises a specific error message' do
    assert_raise_message("symbol as array index"){ @basic['1'.to_sym, 0] = 1 }
  end

  test 'passing a second argument if a range is used causes an error' do
    assert_raise(TypeError, ArgumentError){ @basic[0..1, 2] = 3 }
  end

  def teardown
    @empty = nil
    @basic = nil
  end
end
