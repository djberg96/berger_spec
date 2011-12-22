##########################################################
# test_clear.rb
#
# Test suite for the Array#clear instance method.
##########################################################
require "test/unit"

class Test_Array_Clear_InstanceMethod < Test::Unit::TestCase
  def setup
    @array = [1,2,3]
  end

  test 'clear method basic functionality' do
    assert_respond_to(@array, :clear)
    assert_nothing_raised{ @array.clear }
  end

  test 'clear returns empty array' do
    assert_equal([], @array.clear)
    assert_equal([], [nil, true, false].clear)
  end

  test 'calling the clear method on an empty array is valid' do
    assert_equal([], [].clear)
  end

  test 'clear on nested arrays returns an empty array' do
    assert_equal([], [1, [2, 3], [], 4].clear)
  end

  test 'array returned by clear method is the same underlying object' do
    assert_true(@array.object_id == @array.clear.object_id)
  end

  test 'sending the wrong number of arguments raises an error' do
    assert_raise(ArgumentError){ @array.clear(true) }
  end

  def teardown
    @array = nil
  end
end
