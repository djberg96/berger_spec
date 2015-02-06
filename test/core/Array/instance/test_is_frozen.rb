########################################################################
# test_is_frozen.rb
#
# Test case for the Array#frozen? instance method. This was added
# separately from Object#frozen? because array.c contains a custom
# implementation.
########################################################################
require 'test/helper'
require 'test/unit'

class Test_Array_IsFrozen_InstanceMethod < Test::Unit::TestCase
  def setup
    @bool  = nil
    @array = [5, 1, 3]
  end

  test "frozen basic functionality" do
    assert_respond_to(@array, :frozen?)
    assert_nothing_raised{ @array.frozen? }
    assert_boolean(@array.frozen?)
  end

  test "frozen expected results" do
    assert_false(@array.frozen?)
    assert_nothing_raised{ @array.freeze }
    assert_true(@array.frozen?)
  end

  test "self modifying arrays are not frozen automatically" do
    @array.sort!{ |a,b| @bool = @array.frozen? ; a <=> b }
    assert_false(@bool)
  end

  test "arrays that are not self modifying are not frozen automatically" do
    @array.sort{ |a,b| @bool = @array.frozen? ; a <=> b }
    assert_false(@bool)
  end

  test "passing the wrong number of arguments raises an error" do
    assert_raise(ArgumentError){ @array.frozen?(true) }
  end

  def teardown
    @bool  = nil
    @array = nil
  end
end
