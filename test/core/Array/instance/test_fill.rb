#######################################################################
# test_fill.rb
#
# Test suite for the Array#fill instance method.
#######################################################################
require 'test/helper'
require 'test/unit'

class Test_Array_Fill_InstanceMethod < Test::Unit::TestCase
  def setup
    @array = %w[a b c d]
  end

  test "fill basic functionality" do
    assert_respond_to(@array, :fill)
    assert_nothing_raised{ @array.fill('test') }
    assert_kind_of(Array, @array.fill('test'))
  end

  test "fill with a single object" do
    assert_equal(['x', 'x', 'x', 'x'], @array.fill('x'))
    assert_equal(['z', 'z', 'z', 'z'], @array.fill('z'))
    assert_equal([nil, nil, nil, nil], @array.fill(nil))
  end

  test "fill with an object and a start position" do
    assert_equal(['a', 'b', 'z', 'z'], @array.fill('z', 2))
    assert_equal(['a', 't', 't', 't'], @array.fill('t', -3))
    assert_equal(['a', 't', 't', nil], @array.fill(nil, -1))
  end

  test "fill with an object, a start position and a length" do
    assert_equal(['x', 'x', 3, 4], [1, 2, 3, 4].fill('x', 0, 2))
    assert_equal([1, 'x', 3, 4],   [1, 2, 3, 4].fill('x', 1, 1))
    assert_equal([1, 2, 'x', 'x'],   [1, 2, 3, 4].fill('x', 2, 2))
    assert_equal([1, 'x', 'x', 4], [1, 2, 3, 4].fill('x', -3, 2))
  end

  test "fill with a range" do
    assert_equal(['y', 'y', 'c', 'd'], @array.fill('y', 0..1))
    assert_equal(['y', 'y', 'c', 'd'], @array.fill('y', 2..1))
  end

  test "fill causes array growth if length is greater than array size" do
    assert_equal([1, 2, 'x', 'x', 'x'], [1, 2, 3].fill('x', 2, 3))
    assert_equal([1, 2, 'x', 'x', 'x', 'x'], [1, 2, 3].fill('x', 2..5))
  end

  test "using a float for a start or length is valid" do
    assert_equal(['y','y','c','d'], @array.fill('y', 0.0, 2.7))
    assert_equal(['x','y','c','d'], @array.fill('x', 0.9, 1.2))
    assert_equal(['x','y','c','c','c','c'], @array.fill('c', -1.9, 3.5))
  end

  test "a start of nil is equivalent to zero" do
    assert_equal(['x','x','x','x'], @array.fill('x', nil))
    assert_equal(['z','z','z','z'], @array.fill('z', nil))
  end

  test "a length of nil is equivalent to arr.length" do
    assert_equal(['a','b','x','x'], @array.fill('x', 2, nil))
    assert_equal(['z','z','z','z'], @array.fill('z', nil, nil))
  end

  test "calling fill on an empty array is effectively a no op" do
    assert_equal([], [].fill('x'))
    assert_equal([], [].fill([]))
  end

  test "an error is raised if the wrong number of arguments are provided" do
    assert_raise(ArgumentError){ @array.fill }
    assert_raise(ArgumentError){ @array.fill(1, 2, 3, 4) }
  end

  test "an error is raised if the wrong start type is provided" do
    assert_raise(TypeError){ @array.fill('x', 'x') }
  end

  test "an error is raised if the wrong length type is provided" do
    assert_raise(TypeError){ @array.fill('x', 1, 'x') }
  end

  test "an error is raised if both a range and a length are passed as arguments" do
    assert_raise(TypeError){ @array.fill('x', 0..1, 1) }
  end

  test "error message raised if both a range and a length are passed as arguments" do
    msg = "no implicit conversion of Range into Integer"
    assert_raise_message(msg){ @array.fill('x', 0..1, 1) }
  end

  test "fill is a no-op if the start value exceeds the array length" do
    assert_equal(@array, @array.fill('x', 99))
  end

  test "passing fill a negative length is effectively a no-op" do
    assert_equal(@array, @array.fill('x', 0, -1))
  end

  def teardown
    @array = nil
  end
end
