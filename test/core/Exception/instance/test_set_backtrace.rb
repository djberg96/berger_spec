###############################################################################
# test_set_backtrace.rb
#
# Test case for the Exception#set_backtrace instance method. Note that
# contrary to what the Pickaxe, 2nd edition says, there is no enforcement
# regarding the format of the argument to set_backtrace. Also note that
# it will accept a plain string, in addition to an array of strings.
###############################################################################
require 'test/helper'

class TC_Exception_SetBacktrace_InstanceMethod < Test::Unit::TestCase
  def setup
    @exception = Exception.new
    @backtrace = 'testing'
  end

  test "set_backtrace basic functionality" do
    assert_respond_to(@exception, :set_backtrace)
  end

  test "set_backtrace allows either a string or an array of strings as an argument" do
    assert_nothing_raised{ @exception.set_backtrace('test') }
    assert_nothing_raised{ @exception.set_backtrace(['foo', 'bar']) }
  end

  test "set_backtrace returns an array if the argument is not nil" do
    assert_kind_of(Array, @exception.set_backtrace('test'))
    assert_kind_of(Array, @exception.set_backtrace(['foo', 'bar']))
  end

  test "set_backtrace returns nil if its argument is nil" do
    assert_nil(@exception.set_backtrace(nil))
  end

  test "set_backtrace returns the expected result if a string is passed as an argument" do
    assert_equal(['testing'], @exception.set_backtrace(@backtrace))
    assert_equal(['testing'], @exception.backtrace)
  end

  test "set_backtrace returns the expected result if an array is passed as an argument" do
    assert_equal(['hello', 'world'], @exception.set_backtrace(['hello', 'world']))
    assert_equal(['hello', 'world'], @exception.backtrace)
  end

  test "set_backtrace requires one argument only" do
    assert_raise(ArgumentError){ @exception.set_backtrace }
    assert_raise(ArgumentError){ @exception.set_backtrace('foo', 'bar') }
  end

  test "set_backtrace only accepts a string or an array of strings" do
    assert_raise(TypeError){ @exception.set_backtrace(true) }
    assert_raise(TypeError){ @exception.set_backtrace(0) }
    assert_raise(TypeError){ @exception.set_backtrace(['hello', 0]) }
    assert_raise(TypeError){ @exception.set_backtrace(@exception) }
  end

  def teardown
    @exception = nil
    @backtrace = nil
  end
end
