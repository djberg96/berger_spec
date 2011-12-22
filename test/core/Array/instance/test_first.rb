#######################################################################
# test_first.rb
#
# Test case for the Array#first instance method.
#######################################################################
require 'test/unit'

class Test_Array_First_InstanceMethod < Test::Unit::TestCase
  def setup
    @array = %w/q r s t/
  end

  test "first basic functionality" do
    assert_respond_to(@array, :first)
    assert_nothing_raised{ @array.first }
    assert_nothing_raised{ @array.first(1) }
  end

  test "first expected results" do
    assert_equal('q', @array.first)
    assert_equal(['q'], @array.first(1))
    assert_equal(['q','r','s'], @array.first(3))
  end

  test "first treats a float as an integer" do
    assert_equal(['q'], @array.first(1.5))
    assert_equal(['q','r','s'], @array.first(3.9))
  end

  test "an argument greater than length of array returns the whole array" do
    assert_equal(['q','r','s','t'], @array.first(99))
  end

  test "explicit nils are handled properly" do
    assert_equal([nil], [nil].first(1))
  end

  test "calling first with arguments on an empty array returns an empty array" do
    assert_equal([], @array.first(0))
  end

  test "calling first with no arguments on an empty array returns nil" do
    assert_nil([].first)
  end

  test "an explicit nil is illegal as an argument" do
    assert_raise(TypeError){ @array.first(nil) }
  end

  test "an error is raised if the wrong type of argument is passed" do
    assert_raise(TypeError){ @array.first('foo') }
    assert_raise(TypeError){ @array.first(false) }
    assert_raise(TypeError){ @array.first(true) }
    assert_raise(TypeError){ @array.first(1..3) }
  end

  test "an error is raised if the wrong number of arguments are passed" do
    assert_raise(ArgumentError){ @array.first(1,2) }
  end

  test "an error is raised if a negative value is passed" do
    assert_raise(ArgumentError){ @array.first(-1) }
  end

  def teardown
    @array = nil
  end
end
