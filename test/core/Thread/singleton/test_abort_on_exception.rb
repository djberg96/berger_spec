###############################################################################
# test_abort_on_exception.rb
#
# Test case for the Thread.abort_on_exception and Thread.abort_on_exception=
# singleton methods
###############################################################################
require 'test/helper'
require 'test/unit'

class TC_Thread_AbortOnException_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @orig_stderr = $stderr.dup
    @thread = nil
    Thread.abort_on_exception = false
  end

  test "abort_on_exception basic functionality" do
    assert_respond_to(Thread, :abort_on_exception)
    assert_boolean(Thread.abort_on_exception)
  end

  test "abort_on_exception= basic functionality" do
    assert_respond_to(Thread, :abort_on_exception=)
    assert_true(Thread.abort_on_exception = true)
  end

  test "abort_on_exception returns expected value" do
    assert_false(Thread.abort_on_exception)
    assert_true(Thread.abort_on_exception = true)
    assert_true(Thread.abort_on_exception)
  end

  # NOTE: These are not very good tests.
  test "abort_on_exception behavior when true works as expected" do
    $stderr.reopen(IO::NULL)
    Thread.abort_on_exception = true
    assert_nothing_raised{ @thread = Thread.new{ raise 'ABORT_ON_EXCEPTION TEST' } }
    assert_raise(RuntimeError){ @thread.join }
  end

  test "abort_on_exception behavior when false works as expected" do
    $stderr.reopen(IO::NULL)
    assert_nothing_raised{ @thread = Thread.new{ raise 'ABORT_ON_EXCEPTION TEST' } }
    assert_raise(RuntimeError){ @thread.join }
  end

  test "abort_on_exception does not accept any arguments" do
    assert_raise(ArgumentError){ Thread.abort_on_exception(true) }
  end

  def teardown
    $stderr = @orig_stderr
    @thread = nil
    Thread.abort_on_exception = false
  end
end
