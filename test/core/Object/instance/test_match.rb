########################################################################
# test_match.rb
#
# Test case for the Object#=~ instance method. This is a very short
# test case because Object#=~ always returns nil. It is meant to be
# overridden by subclasses.
########################################################################
require 'test/helper'
require 'test/unit'

class TC_Object_Match_InstanceMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @object = Object.new
  end

  test "=~ basic functionality" do
    assert_respond_to(@object, :=~)
    suppress_warning{ assert_nothing_raised{ @object =~ @object } }
  end

  test "=~ returns the expected result" do
    suppress_warning{ assert_nil(@object =~ @object) }
  end

  test "=~ accepts one argument only" do
    assert_raise(ArgumentError){ @object.send(:=~) }
    assert_raise(ArgumentError){ @object.send(:=~, 1, 2) }
  end

  def teardown
    @object = nil
  end
end
