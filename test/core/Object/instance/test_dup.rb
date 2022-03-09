#######################################################################
# test_dup.rb
#
# Test case for the Object#dup instance method.
#######################################################################
require 'test/helper'
require 'test/unit'

class ObjectDup
  attr_accessor :str
end

class TC_Object_Dup_InstanceMethod < Test::Unit::TestCase
  def setup
    @object = Object.new
    @dup    = nil
    @string = 'Hello'
    @custom = ObjectDup.new
    @custom.str = @string
  end

  test "dup basic functionality" do
    assert_respond_to(@object, :dup)
    assert_nothing_raised{ @object.dup }
  end

  test "dup creates a new object" do
    assert_nothing_raised{ @dup = @object.dup }
    assert_false(@dup.object_id == @object.object_id)
  end

  test "instance variables retain their value from dup" do
    assert_nothing_raised{ @dup = @custom.dup }
    assert_equal('Hello', @dup.str)
    assert_nothing_raised{ @custom.str[1,4] = 'i' }
    assert_equal('Hi', @custom.str)
    assert_equal('Hi', @dup.str)
  end

  test "dup does not keep frozen state of original" do
    assert_nothing_raised{ @custom.freeze }
    assert_nothing_raised{ @dup = @custom.dup }
    assert_true(@custom.frozen?)
    assert_false(@dup.frozen?)
  end

  test "dup does not accept any arguments" do
    assert_raise(ArgumentError){ @object.dup(true) }
  end

  test "primitive objects can be dup'ed" do
    assert_nothing_raised{ 7.dup }
    assert_nothing_raised{ nil.dup }
    assert_nothing_raised{ true.dup }
    assert_nothing_raised{ false.dup }
    assert_nothing_raised{ 'hello'.to_sym.dup }
  end

  def teardown
    @object = nil
    @dup  = nil
    @custom = nil
  end
end
