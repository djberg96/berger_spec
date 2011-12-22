#######################################################################
# test_last.rb
#
# Test case for the Array#last instance method.
#######################################################################
require 'test/unit'

class Test_Array_Last_InstanceMethod < Test::Unit::TestCase
  def setup
    @array = %w/q r s t/
  end

  test "last basic functionality" do
    assert_respond_to(@array, :last)
    assert_nothing_raised{ @array.last }
    assert_nothing_raised{ @array.last(1) }
  end

  test "last expected results" do
    assert_equal('t', @array.last)
    assert_equal(['t'], @array.last(1))
    assert_equal(['r','s','t'], @array.last(3))
  end

  test "last treats a float as an integer" do
    assert_equal(['t'], @array.last(1.5))
    assert_equal(['r','s','t'], @array.last(3.9))
  end

  test "an argument greater than length of array returns the whole array" do
    assert_equal(['q','r','s','t'], @array.last(99))
  end

  test "explicit nils are handled properly" do
    assert_equal([nil], [nil].last(1))
  end

  test "calling last with arguments on an empty array returns an empty array" do
    assert_equal([], @array.last(0))
  end

  test "calling last with no arguments on an empty array returns nil" do
    assert_nil([].last)
  end

  test "an explicit nil is illegal as an argument" do
    assert_raise(TypeError){ @array.last(nil) }
  end

  test "an error is raised if the wrong type of argument is passed" do
    assert_raise(TypeError){ @array.last('foo') }
    assert_raise(TypeError){ @array.last(false) }
    assert_raise(TypeError){ @array.last(true) }
    assert_raise(TypeError){ @array.last(1..3) }
  end

  test "an error is raised if the wrong number of arguments are passed" do
    assert_raise(ArgumentError){ @array.last(1,2) }
  end

  test "an error is raised if a negative value is passed" do
    assert_raise(ArgumentError){ @array.last(-1) }
  end

  def teardown
    @array = nil
  end
end
