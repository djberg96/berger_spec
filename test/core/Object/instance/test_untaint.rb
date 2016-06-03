########################################################################
# test_untaint.rb
#
# Test case for the Object#untaint instance method.
########################################################################
require 'test/helper'
require 'test-unit'

class TC_Object_Untaint_InstanceMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @object = Object.new
    @object.taint
  end

  test "untaint basic functionality" do
    assert_respond_to(@object, :untaint)
    assert_nothing_raised{ @object.untaint }
    assert_equal(@object, @object.untaint)
  end

  test "untaint works as expected" do
    assert_true(@object.tainted?)
    assert_equal(@object, @object.untaint)
    assert_false(@object.tainted?)
  end

  test "calling untaint multiple times is ok" do
    assert_equal(@object, @object.untaint)
    assert_equal(@object, @object.untaint)
    assert_false(@object.tainted?)
  end

  test "calling untaint on a frozen object raises an error" do
    assert_nothing_raised{ @object.taint }
    assert_nothing_raised{ @object.freeze }
    assert_raise(RuntimeError){ @object.untaint }
  end

  test "untaint does not accept any arguments" do
    assert_raise(ArgumentError){ @object.untaint(true) }
  end

  def teardown
    @object = nil
  end
end
