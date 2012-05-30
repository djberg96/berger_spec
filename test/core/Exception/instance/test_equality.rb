########################################################################
# test_equality.rb
#
# Tests for the Exception#== method.
########################################################################
require 'test/helper'

class TC_Exception_Equals < Test::Unit::TestCase
  class TestError
    attr_accessor :message
    attr_writer :backtrace

    def initialize(msg = nil)
      @message = msg
    end

    def backtrace
      @backtrace ? [@backtrace] : nil
    end
  end

  def setup
    @error1 = Exception.new
    @error2 = Exception.new
    @custom = TestError.new
  end

  test "exceptions are equal if object and receiver are the same" do
    assert_true(@error1 == @error1)
  end

  test "exceptions are equal if their messages and backtraces are both nil" do
    assert_true(@error1 == @error2)
  end

  test "exceptions are equal if their messages and backtraces are the same" do
    @error1 = Exception.new('foo')
    @error2 = StandardError.new('foo')
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

  test "equality is false if object compared against does not implement message and backtrace functions" do
    assert_false(@error1 == [])
    assert_false(@error1 == {})
    assert_false(@error1 == 0)
  end

  test "equality is true if object compared against implements message and backtrace functions and they are the same" do
    assert_true(@error1 == @custom)

    @error1.set_backtrace('foo')
    @custom.backtrace = 'foo'

    assert_true(@error1 == @custom)

    @error1 = Exception.new('bar')
    @custom = TestError.new('bar')

    assert_true(@error1 == @custom)
  end

  test "equality is false if object compared against implements message and backtrace functions and they are not the same" do
    assert_true(@error1 == @custom)

    @error1.set_backtrace('foo')
    @custom.backtrace = 'bar'

    assert_false(@error1 == @custom)

    @error1.set_backtrace('bar')
    assert_true(@error1 == @custom)

    @error1 = Exception.new('foo')
    @custom = TestError.new('bar')

    assert_false(@error1.message == @custom.message)
    assert_false(@error1 == @custom)
  end

  def teardown
    @error1 = nil
    @error2 = nil
    @custom = nil
  end
end
