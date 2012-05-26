###############################################################################
# test_to_s.rb
#
# Test case for the Exception#to_s instance method.
###############################################################################
require 'test/helper'

class TC_Exception_ToS_InstanceMethod < Test::Unit::TestCase
  def setup
    @err1 = Exception.new
    @err2 = Exception.new('hello')
  end

  test "to_s basic functionality" do
    assert_respond_to(@err1, :to_s)
    assert_nothing_raised{ @err1.to_s }
    assert_kind_of(String, @err1.to_s)
  end

  test "to_s returns the expected results" do
    assert_equal('Exception', @err1.to_s)
    assert_equal('hello', @err2.to_s)
  end

  test "if the exception is tainted, so is its message" do
    assert_nothing_raised{ @err2.taint }
    assert_true(@err2.message.tainted?)
  end

  test "to_s does not accept any arguments" do
    assert_raise(ArgumentError){ @err1.to_s(true) }
  end

  def teardown
    @err1 = nil
    @err2 = nil
  end
end
