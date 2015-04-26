########################################################################
# test_freeze.rb
#
# Test case for the Object#freeze instance method.
########################################################################
require 'test/helper'
require 'test/unit'

class TC_Object_Freeze_InstanceMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @object = Object.new
  end

  test "freeze basic functionality" do
    assert_respond_to(@object, :freeze)
    assert_nothing_raised{ @object.freeze }
    assert_equal(@object, @object.freeze)
  end

  test "freeze works as expected" do
    assert_false(@object.frozen?)
    assert_nothing_raised{ @object.freeze }
    assert_true(@object.frozen?)
  end

  test "calling freeze multiple times is ok" do
    assert_nothing_raised{ @object.freeze }
    assert_nothing_raised{ @object.freeze }
    assert_nothing_raised{ @object.freeze }
    assert_true(@object.frozen?)
  end

  test "test freeze does not accept any arguments" do
    assert_raise(ArgumentError){ @object.freeze(true) }
  end

  def teardown
    @object = nil
  end
end
