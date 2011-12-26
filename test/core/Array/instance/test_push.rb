###########################################################
# test_push.rb
#
# Test suite for the Array#push instance method.
###########################################################
require 'test/helper'
require 'test/unit'

class Test_Array_Push_InstanceMethod < Test::Unit::TestCase
  def setup
    @array = [1, 2, 3]
  end

  test "push basic functionality" do
    assert_respond_to(@array, :push)
    assert_nothing_raised{ @array.push(1) }
    assert_nothing_raised{ @array.push(1, 'a') }
    assert_kind_of(Array, @array.push('a'))
  end

  test "push expected results for basic arrays" do
    assert_equal([1, 2, 3, 4], @array.push(4))
    assert_equal([1, 2, 3, 4, 'five'], @array.push('five'))
    assert_equal([1, 2, 3, 4, 'five', nil], @array.push(nil))
    assert_equal([1,2,3,4,'five',nil,false,true], @array.push(false, true))
  end

  test "flattening behavior with push" do
    assert_equal([1, 2, 3, [4, 5]], [1, 2, 3].push([4,5]))
    assert_equal([1, 2, 3, 4, 5], [1, 2, 3].push(*[4,5]))
  end

  test "pushing an array onto itself works as expected" do
    assert_nothing_raised{ @array.push(@array) }
    assert_equal(1, @array[0])
    assert_equal(2, @array[1])
    assert_equal(3, @array[2])
    assert_equal(@array, @array[3])
  end

  test "push returns itself" do
    assert_true(@array.object_id == @array.push('a').object_id)
  end

  test "calling push without an argument returns itself" do
    assert_equal(@array, @array.push)
    assert_equal(@array.object_id, @array.push.object_id)
  end

  def teardown
    @array = nil
  end
end
