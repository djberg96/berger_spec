########################################################################
# test_compact.rb
#
# Test suite for the Array#compact instance method.
#
# The tests for the Array#compact! instance method can be found in the
# test_compact_bang.rb file.
########################################################################
require 'test/unit'

class Test_Array_Compact_InstanceMethod < Test::Unit::TestCase
  def setup
    @numbers = [0, 1, 2, 3]
    @mixed   = [1, 'two', nil, false, nil]
  end

  test 'compact basic functionality' do
    assert_respond_to(@mixed, :compact)
    assert_nothing_raised{ @mixed.compact }
  end

  test 'compact returns expected value' do
    assert_equal([1, 'two', false], @mixed.compact)
    assert_equal([0, 1, 2, 3], @numbers.compact)
  end

  test 'original receiver is not modified' do
    assert_nothing_raised{ @mixed.compact }
    assert_equal([1, 'two', nil, false, nil], @mixed)
  end

  test 'compact on an empty array returns an empty array' do
    assert_equal([], [].compact)
  end

  test 'compact on an array that only contains nil returns an empty array' do
    assert_equal([], [nil, nil, nil].compact)
  end

  test 'nested arrays that contain nil are unaffected' do
    assert_equal([[nil]], [[nil]].compact)
    assert_equal([[nil]], [nil, [nil]].compact)
  end

  test 'the wrong number of arguments raises an error' do
    assert_raise(ArgumentError){ @numbers.compact(1) }
  end

  def teardown
    @numbers = nil
    @mixed   = nil
  end
end
