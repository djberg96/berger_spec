###############################################################################
# test_exception.rb
#
# Test case for the Exception#exception instance method.
###############################################################################
require 'test/helper'

class TC_Exception_Exception_InstanceMethod < Test::Unit::TestCase
  class TestException < Exception; end

  def setup
    @exception = TestException.new
    @object    = nil
  end

  test "exception method basic functionality" do
    assert_respond_to(@exception, :exception)
    assert_nothing_raised{ @exception.exception }
  end

  test "exception method accepts an optional string argument" do
    assert_nothing_raised{ @object = @exception.exception('test') }
    assert_equal('test', @object.message)
  end

  test "exception method without an argument returns itself" do
    assert_kind_of(TestException, @exception.exception)
    assert_equal(@exception.object_id, @exception.exception.object_id)
  end

  test "exception method with itself as the argument returns itself" do
    assert_kind_of(TestException, @exception.exception(@exception))
    assert_equal(@exception.object_id, @exception.exception.object_id)
  end

  test "adding a messge to the exception method creates a new exception object" do
    @object = @exception.exception('test')
    assert_kind_of(TestException, @object)
    assert_not_equal(@object.object_id, @exception.object_id)
    assert_not_equal(@object.message, @exception.message)
  end

  test "exception method accepts only argument" do
    assert_raise(ArgumentError){ @exception.message('hello', 'world') }
  end

  test "exception method raises an ArgumentError if the argument is not a string or itself" do
    assert_raise(ArgumentError){ @exception.message(1) }
  end

  def teardown
    @exception = nil
    @object    = nil
  end
end
