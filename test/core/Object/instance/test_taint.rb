########################################################################
# test_taint.rb
#
# Test case for the Object#taint instance method.
########################################################################
require 'test/helper'
require 'test-unit'

class TC_Object_Taint_InstanceMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @object = Object.new
  end

  test "taint basic functionality" do
    assert_respond_to(@object, :taint)
    assert_nothing_raised{ @object.taint }
    assert_equal(@object, @object.taint)
  end

  test "taint works as expected" do
    assert_false(@object.tainted?)
    assert_nothing_raised{ @object.taint }
    assert_true(@object.tainted?)
  end

  test "calling taint multiple times is ok" do
    assert_nothing_raised{ @object.taint }
    assert_nothing_raised{ @object.taint }
    assert_nothing_raised{ @object.taint }
    assert_true(@object.tainted?)
  end

  test "calling taint on a frozen object raises an error" do
    assert_nothing_raised{ @object.freeze }
    assert_raise(RuntimeError){ @object.taint }
  end

  test "taint does not accept any arguments" do
    assert_raise(ArgumentError){ @object.taint(true) }
  end

  def teardown
    @object = nil
  end
end
