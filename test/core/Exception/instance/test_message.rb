###############################################################################
# test_message.rb
#
# Test case for the Exception#message instance method.
###############################################################################
require 'test/helper'

class TC_Exception_Message_InstanceMethod < Test::Unit::TestCase
  def setup
    @message    = 'Message Test'
    @exception1 = Exception.new(@message)
    @exception2 = Exception.new
  end

  test "message basic functionality" do
    assert_respond_to(@exception1, :message)
    assert_nothing_raised{ @exception1.message }
    assert_kind_of(String, @exception1.message)
  end

  test "message method returns the expected result" do
    assert_equal('Message Test', @exception1.message)
    assert_equal('Exception', @exception2.message)
  end

  test "message method does not accept any arguments" do
    assert_raise(ArgumentError){ @exception1.message(1) }
  end

  def teardown
    @message    = nil
    @exception1 = nil
    @exception2 = nil
  end
end
