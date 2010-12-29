########################################################################
# tc_untaint.rb
#
# Test case for the Object#untaint instance method.
########################################################################
require 'test/helper'
require 'test/unit'

class TC_Object_Untaint_InstanceMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @object = Object.new
  end

  def test_untaint_basic
    assert_respond_to(@object, :untaint)
    assert_nothing_raised{ @object.untaint }
  end

  def test_untaint
    assert_equal(@object, @object.untaint)
    assert_equal(@object, @object.untaint) # Duplicate intentional
    assert_equal(false, @object.tainted?)
  end

  def test_untaint_frozen_objects
    assert_nothing_raised{ @object.taint }
    assert_nothing_raised{ @object.freeze }
    assert_raise(TypeError){ @object.untaint }
  end

  def test_untaint_safe_environment
    omit_if(JRUBY, "untaint tests in $SAFE environment skipped on JRuby")
    assert_nothing_raised{ @object.taint }
    assert_nothing_raised{
      proc do
        $SAFE = 2
        @object.untaint
      end.call
    }
    assert_raise(SecurityError){
      proc do
        $SAFE = 3
        @object.untaint
      end.call
    }
  end

  def test_untaint_expected_errors
    assert_raise(ArgumentError){ @object.untaint(true) }
  end

  def teardown
    @object = nil
  end
end
