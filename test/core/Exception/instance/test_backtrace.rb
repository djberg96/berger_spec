###############################################################################
# test_backtrace.rb
#
# Test case for the Exception#backtrace instance method.
###############################################################################
require 'test/helper'

class TC_Exception_Backtrace_InstanceMethod < Test::Unit::TestCase
  def setup
    @exception = RuntimeError.new
  end

  test "backtrace basic functionality" do
    assert_respond_to(@exception, :backtrace)
    assert_nothing_raised{ @exception.backtrace }
  end

  test "backtrace returns an array" do
    begin; 1/0; rescue Exception => @exception; end
    assert_not_nil(@exception.backtrace)
    assert_kind_of(Array, @exception.backtrace)
  end

  test "backtrace format includes the file name, line number, and 'in' followed by method name" do
    begin; 1/0; rescue Exception => @exception; end
    regex = /.*?test_backtrace\.rb:\d+:in.+/i
    assert_not_nil(regex.match(@exception.backtrace.first))
  end

  test "backtrace method does not accept any arguments" do
    assert_raise(ArgumentError){ @exception.backtrace(true) }
  end

  def teardown
    @exception = nil
  end
end
