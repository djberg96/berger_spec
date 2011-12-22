########################################################################
# test_fetch.rb
#
# Tests for the Array#fetch instance method.
########################################################################
require 'test/unit'

class TC_Array_Fetch < Test::Unit::TestCase
  def setup
    @array = ['a', 'b', 'c', 'd']
  end

  test "fetch basic functionality" do
    assert_respond_to(@array, :fetch)
    assert_nothing_raised{ @array.fetch(0) }
    assert_nothing_raised{ @array.fetch(0, 'default') }
    assert_nothing_raised{ @array.fetch(0){} }
  end

  test "fetch with index returns expected results" do
    assert_equal('a', @array.fetch(0))
    assert_equal('b', @array.fetch(1))
  end

  test "fetch with a negative index returns expected results" do
    assert_equal('d', @array.fetch(-1))
    assert_equal('c', @array.fetch(-2))
  end

  test "fetch with default value returns default value if index out of bounds" do
    assert_equal('default', @array.fetch(99, 'default'))
    assert_equal('default', @array.fetch(-99, 'default'))
  end

  test "fetch with default value returns expected value if index in bounds" do
    assert_equal('a', @array.fetch(0, 'default'))
    assert_equal('d', @array.fetch(-1, 'default'))
  end

  test "fetch with block returns block value if index out of bounds" do
    assert_equal(100, @array.fetch(99){ |i| i + 1 })
    assert_equal('default', @array.fetch(99){ 'default' })
  end

  test "at least one argument is required or an error is raised" do
    assert_raise(ArgumentError){ @array.fetch }
  end

  test "the first form raises an error if the index is out of bounds" do
    assert_raise(IndexError){ @array.fetch(99) }
    assert_raise(IndexError){ @array.fetch(-99) }
  end

  test "an error is raised if an invalid argument type is used" do
    assert_raise(TypeError){ @array.fetch('a') }
    assert_raise(TypeError){ @array.fetch([]) }
    assert_raise(TypeError){ @array.fetch(nil) }
  end

  def teardown
    @array = nil
  end
end
