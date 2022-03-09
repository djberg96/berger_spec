#######################################################################
# test_clone.rb
#
# Test case for the Object#clone instance method.
#######################################################################
require 'test/helper'
require 'test/unit'

class ObjectClone
  attr_accessor :str
end

class TC_Object_Clone_InstanceMethod < Test::Unit::TestCase
  def setup
    @object = Object.new
    @clone  = nil
    @string = 'Hello'

    @custom = ObjectClone.new
    @custom.str = @string
  end

  test "clone basic functionality" do
    assert_respond_to(@object, :clone)
    assert_nothing_raised{ @object.clone }
  end

  test "clone creates a separate object" do
    assert_nothing_raised{ @clone = @object.clone }
    assert_false(@clone.object_id == @object.object_id)
  end

  test "cloned instance variables are retained" do
    assert_nothing_raised{ @clone = @custom.clone }
    assert_equal('Hello', @clone.str)
    assert_nothing_raised{ @custom.str[1,4] = 'i' }
    assert_equal('Hi', @custom.str)
    assert_equal('Hi', @clone.str)
  end

  test "a cloned object retains the original object's frozen state" do
    assert_nothing_raised{ @custom.freeze }
    assert_nothing_raised{ @clone = @custom.clone }
    assert_true(@custom.frozen?)
    assert_true(@clone.frozen?)
  end

  test "clone does not accept any arguments" do
    assert_raise(ArgumentError){ @object.clone(true) }
  end

  test "cloning primitive objects is permitted" do
    assert_nothing_raised{ 7.clone }
    assert_nothing_raised{ nil.clone }
    assert_nothing_raised{ true.clone }
    assert_nothing_raised{ false.clone }
    assert_nothing_raised{ 'hello'.to_sym.clone }
  end

  def teardown
    @object = nil
    @clone  = nil
    @custom = nil
  end
end
