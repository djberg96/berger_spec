#######################################################################
# test_to_a.rb
#
# Test suite for the Array#to_a instance method.
#######################################################################
require 'test/helper'
require 'test/unit'

class Test_Array_ToA_InstanceMethod < Test::Unit::TestCase
  class ArrayToA < Array; end

  def setup
    @array = [1, 2, 3]
    @subclass = ArrayToA.new
  end

  test "to_a basic functionality" do
    assert_respond_to(@array, :to_a)
    assert_nothing_raised{ @array.to_a }
    assert_kind_of(Array, @array.to_a)
  end
   
  test "to_a returns itself when called on core Array instance" do
    assert_equal(@array, @array.to_a)
    assert_equal(@array.object_id, @array.to_a.object_id)
  end

  test "to_a converts a subclass back to an Array" do
    assert_equal(ArrayToA, @subclass.class)
    assert_equal(Array, @subclass.to_a.class)
  end

  test "an error is raised if the wrong number of arguments are passed" do
    assert_raise(ArgumentError){ @array.to_a(1) }
  end

  def teardown
    @array = nil
    @subclass = nil
  end
end
