########################################################################
# test_equality.rb
#
# Tests for the Exception#== method. There are some tests that were
# intentionally omitted. See https://bugs.ruby-lang.org/issues/5865.
########################################################################
require 'test/helper'

class TC_Exception_Equals < Test::Unit::TestCase
  def setup
    @error1 = Exception.new
    @error2 = Exception.new
  end

  test "exceptions are equal if object and receiver are the same" do
    assert_true(@error1 == @error1)
  end

  test "exceptions are equal if their messages and backtraces are both nil" do
    assert_true(@error1 == @error2)
  end

  test "exceptions are equal if their messages and backtraces are the same" do
    @error1 = Exception.new('foo')
    @error2 = Exception.new('foo')
    assert_true(@error1 == @error2)

    @error1.set_backtrace('bar')
    @error2.set_backtrace('bar')
    assert_true(@error1 == @error2)
  end

  test "exceptions are not equal if the messages are not the same" do
    @error1 = Exception.new('foo')
    @error2 = Exception.new('bar')

    assert_false(@error1 == @error2)
  end

  test "exceptions are not equal if the backtraces are not the same" do
    @error1.set_backtrace('foo')
    @error2.set_backtrace('bar')

    assert_false(@error1 == @error2)
  end

  test "equality is false if object is not an exception" do
    assert_false(@error1 == [])
    assert_false(@error1 == {})
    assert_false(@error1 == 0)
  end

  def teardown
    @error1 = nil
    @error2 = nil
    @custom = nil
  end
end
