#######################################################################
# test_at.rb
#
# Test suite for the Array#at instance method.
#######################################################################
require 'test/unit'

class Test_Array_At_InstanceMethod < Test::Unit::TestCase
  def setup
    @array = [1, 'two', true, false, nil, 9]
  end

  test 'at basic functionality' do
    assert_respond_to(@array, :at)
    assert_nothing_raised{ @array.at(0) }
  end

  test 'results for positive values in bounds' do
    assert_equal(1, @array.at(0))
    assert_equal(9, @array.at(5))
    assert_equal(true, @array.at(2))
  end

  test 'a positive value out of bounds returns nil' do
    assert_nil(@array.at(99))
  end

  test 'results for negative values in bounds' do
    assert_equal(9, @array.at(-1))
    assert_equal(false, @array.at(-3))
  end

  test 'a negative value out of bounds returns nil' do
    assert_nil(@array.at(-99))
  end

  test 'a float value is valid and rounded to a fixnum' do
    assert_equal(1, @array.at(0.9))
    assert_equal(9, @array.at(5.0))
    assert_equal(9, @array.at(-1.9))
  end

  test 'a float value out of bounds returns nil' do
    assert_nil(@array.at(99.4))
    assert_nil(@array.at(-99.4))
  end

  test 'method does not accept a range' do
    assert_raise(TypeError){ @array.at(0..2) }
  end

  test 'raises an error if the wrong type of argument is passed' do
    assert_raise(TypeError){ @array.at(nil) }
    assert_raise(TypeError){ @array.at('a') }
  end

  test 'raises an error if the wrong number of arguments are passed' do
    assert_raise(ArgumentError){ @array.at }
    assert_raise(ArgumentError){ @array.at(1, 2) }
  end

  def teardown
    @array = nil
  end
end
