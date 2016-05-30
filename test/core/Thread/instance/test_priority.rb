########################################################################
# test_priority.rb
#
# Test case for the Thread#priority and Thread#priority= instance
# methods.
########################################################################
require 'test/helper'
require 'test/unit'

class TC_Thread_Priority_InstanceMethod < Test::Unit::TestCase
  def setup
    @thread = Thread.new{ sleep 1 while true }
  end

  test "priority basic functionality" do
    assert_respond_to(@thread, :priority)
    assert_nothing_raised{ @thread.priority }
    assert_kind_of(Integer, @thread.priority)
  end

  test "priority returns the expected value" do
    assert_respond_to(@thread, :priority=)
    assert_nothing_raised{ @thread.priority = 5 }
    assert_kind_of(Integer, @thread.priority = 5)
  end

  test "the default priority is zero" do
    assert_equal(0, @thread.priority) # The default
  end

  test "priority returns the set value" do
    assert_nothing_raised{ @thread.priority = 3 }
    assert_true(@thread.priority > 0)
  end

  test "setting priority to a negative value is legal" do
    assert_nothing_raised{ @thread.priority = -3 }
    assert_true(@thread.priority < 0)
  end

  test "setting priority to a float value is legal" do
    assert_nothing_raised{ @thread.priority = 2.5 }
    assert_equal(2, @thread.priority) # Converted to int
  end

  test "priority method does not take any arguments" do
    assert_raise(ArgumentError){ @thread.priority(1) }
  end

  test "priority= method accepts only one argument" do
    assert_raise(ArgumentError){ @thread.send(:priority=, 1, 2) }
  end

  def teardown
    @thread.exit
    @thread = nil
  end
end
