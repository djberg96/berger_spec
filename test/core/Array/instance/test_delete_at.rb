#######################################################################
# test_delete_at.rb
#
# Test case for the Array#delete_at instance method.
#######################################################################
require 'test/unit'

class Test_Array_DeleteAt_InstanceMethod < Test::Unit::TestCase
  def setup
    @array = [1, 2, 3]
  end

  test "delete_at basic functionality" do
    assert_respond_to(@array, :delete_at)
    assert_nothing_raised{ @array.delete_at(0) }
  end

  test "delete at returns the object if deleted" do
    assert_equal(2, @array.delete_at(1))
    assert_equal(3, @array.delete_at(-1))
  end

  test "delete at returns nil if the object is not found" do
    assert_equal(nil, @array.delete_at(5))
    assert_equal(nil, @array.delete_at(-5))
  end

  test "delete at modifies the receiver if object is found" do
    assert_nothing_raised{ @array.delete_at(1) }
    assert_equal([1, 3], @array)
  end

  test "delete at does not modify the receiver if the object is not found" do
    assert_nothing_raised{ @array.delete_at(99) }
    assert_equal([1, 2, 3], @array)
  end

  test "delete_at accepts and rounds down float values" do
    assert_equal(2, @array.delete_at(1.5))
    assert_equal(nil, @array.delete_at(5.0))
    assert_equal(nil, @array.delete_at(-5.9))
  end

  test "an error is raised if the wrong number of arguments are provided" do
    assert_raise(ArgumentError){ @array.delete_at }
    assert_raise(ArgumentError){ @array.delete_at(1, 2) }
  end

  test "an error is raised if the wrong type of argument is provided" do
    assert_raise(TypeError){ @array.delete_at('foo') }
    assert_raise(TypeError){ @array.delete_at(nil) }
  end

  def teardown
    @array = nil
  end
end
