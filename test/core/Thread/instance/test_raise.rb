########################################################################
# test_raise.rb
#
# Test case for the Thread#raise instance method.
########################################################################
require 'test/helper'
require 'test/unit'

class TC_Thread_Raise_InstanceMethod < Test::Unit::TestCase
  def setup
    @thread = Thread.new{ sleep }
    @stderr = $stderr.dup
    Thread.pass until @thread.status == 'sleep'
  end

  test "raise basic functionality" do
    assert_respond_to(@thread, :raise)
  end

  test "raises a RuntimeError if a raised thread is joined" do
    Thread.pass until @thread.status == 'sleep'
    assert_nothing_raised{ @thread.raise }
    assert_raise(RuntimeError){ @thread.join }
  end

  test "raises the specified message if a raised thread is joined" do
    assert_nothing_raised{ @thread.raise('hello') }

    begin
      @thread.join
    rescue RuntimeError => msg
      assert_equal('hello', msg.to_s)
    end
  end

  test "raises the specified error class if provided as an argument" do
    assert_nothing_raised{ @thread.raise(StandardError) }

    begin
      @thread.join
    rescue StandardError => msg
      assert_equal('StandardError', msg.to_s)
    end
  end

  test "raises the specified error class with the given message if provided" do
    assert_nothing_raised{ @thread.raise(StandardError, 'hello') }

    begin
      @thread.join
    rescue StandardError => msg
      assert_equal('hello', msg.to_s)
    end
  end

  test "raises the specified error class with the given message and backtrace if provided" do
    assert_nothing_raised{ @thread.raise(NameError, 'hello', %/foo bar/) }

    begin
      @thread.join
    rescue NameError => msg
      assert_equal('hello', msg.to_s)
      assert_equal('foo bar', msg.backtrace[0])
    end
  end

  test "raise accepts a maximum of three arguments" do
    assert_raise(ArgumentError){ @thread.raise(1,2,3,4) }
  end

  def teardown
    @thread.exit if @thread
    @thread = nil
  end
end
