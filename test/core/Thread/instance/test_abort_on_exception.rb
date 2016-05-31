###############################################################################
# test_abort_on_exception.rb
#
# Test case for the Thread#abort_on_exception and Thread#abort_on_exception=
# instance methods
###############################################################################
require 'test/helper'
require 'test/unit'

class TC_Thread_AbortOnException_InstanceMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @thread = Thread.new{ raise 'AOE TEST' }
  end

  test "abort_on_exception basic functionality" do
    assert_respond_to(@thread, :abort_on_exception)
    assert_boolean(@thread.abort_on_exception)
  end

  test "abort_on_exception= basic functionality" do
    assert_respond_to(@thread, :abort_on_exception=)
    assert_false(@thread.abort_on_exception = false)
  end

  test "abort_on_exception returns the expected value" do
    assert_false(@thread.abort_on_exception)
    assert_true(@thread.abort_on_exception = true)
    assert_true(@thread.abort_on_exception)
  end

  test "thread with exception raises error when joined" do
    assert_raise(RuntimeError){ @thread.join }
  end

  test "abort_on exception does not accept any arguments" do
    assert_raise(ArgumentError){ Thread.abort_on_exception(true) }
  end

  def teardown
    @thread.exit
    @thread.abort_on_exception = false
    @thread = nil
  end
end
