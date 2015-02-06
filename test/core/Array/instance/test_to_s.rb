########################################################################
# test_to_s.rb
#
# Test case for the Array#to_s instance method.
########################################################################
require 'test/helper'
require 'test/unit'

class Test_Array_InspectMethod_InstanceMethod < Test::Unit::TestCase
  def setup
    @empty     = []
    @normal    = [1, 'a', 2]
    @recursive = [1, 'a', 2]
    @recursive << @recursive
  end

  test "to_s basic functionality" do
    assert_respond_to(@empty, :to_s)
    assert_nothing_raised{ @empty.to_s }
    assert_kind_of(String, @empty.to_s)
  end

  test "to_s on a simple array works as expected" do
    assert_equal('[1, "a", 2]', @normal.to_s)
  end

  test "to_s on an empty array returns expected value" do
    assert_equal('[]', @empty.to_s)
  end

  test "to_s on a recursive array works as expected" do
    assert_equal('[1, "a", 2, [...]]', @recursive.to_s)
  end

  test "passing the wrong number of arguments raises an error" do
    assert_raise(ArgumentError){ @normal.to_s(true) }
  end

  def teardown
    @empty     = nil
    @normal    = nil
    @recursive = nil
  end
end
