######################################################
# test_include.rb
#
# Test suite for the Array#include? method.
######################################################
require "test/unit"

class Test_Array_Include_InstanceMethod < Test::Unit::TestCase
  def setup
    @array = ["one", 2, nil, false, true, 3]
  end

  test "include basic functionality" do
    assert_respond_to(@array, :include?)
    assert_nothing_raised{ @array.include?(2) }
    assert_boolean(@array.include?(2))
  end

  test "include expected true results" do
    assert_true(@array.include?("one"))
    assert_true(@array.include?(2))
    assert_true(@array.include?(nil))
    assert_true(@array.include?(false))
    assert_true(@array.include?(true))
  end

  test "include expected false results" do
    assert_false(@array.include?("2"))
    assert_false(@array.include?("nil"))
    assert_false(@array.include?("false"))
  end

  test "include works with recursive arrays as expected" do
    @array = @array << @array
    assert_true(@array.include?(@array))
  end

  test "an error is raised if the wrong number of arguments are passed" do
    assert_raise(ArgumentError){ @array.include?(1,2) }
  end

  def teardown
    @array = nil
  end
end
