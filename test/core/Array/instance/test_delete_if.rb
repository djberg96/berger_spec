###########################################################
# test_delete_if.rb
#
# Test suite for the Array#delete_if instance method.
###########################################################
require "test/unit"

class Test_Array_DeleteIf_InstanceMethod < Test::Unit::TestCase
  def setup
    @array = [1, 2, 3, 4]
  end

  test "delete_if basic functionality" do
    assert_respond_to(@array, :delete_if)
    assert_nothing_raised{ @array.delete_if{ } }
  end

  test "delete_if expected results" do
    assert_nothing_raised{ @array.delete_if{ |x| x > 2 } }
    assert_equal([1, 2], @array)
  end

  test "delete_if returns original array if no deletions are made" do
    assert_equal(@array, @array.delete_if{ |x| x > 5 })
  end

  test "delete_if deletes everything if block yields a true value" do
    assert_nothing_raised{ @array.delete_if{ true } }
    assert_equal([], @array)
  end

  test "an error is raised if the wrong number of arguments are passed" do
    assert_raise(ArgumentError){ @array.delete_if(1) }
  end

  def teardown
    @array = nil
  end
end
