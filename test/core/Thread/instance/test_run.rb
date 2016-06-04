########################################################################
# test_run.rb
#
# Test case for the Thread#run instance method.
########################################################################
require 'test/helper'
require 'test/unit'

class TC_Thread_Run_InstanceMethod < Test::Unit::TestCase

  # For the setup I've created multiple break points to ensure that a call
  # to Thread#run only runs up to the next breakpoint.
  #
  def setup
    @num1 = 0
    @num2 = 0

    @thread = Thread.new{
      Thread.stop
      @num1 = 88
      Thread.stop
      @num2 = 99
    }
  end

  test "run basic functionality" do
    assert_respond_to(@thread, :run)
    assert_nothing_raised{ @thread.run }
  end

  test "variables are set to expected values before run is called" do
    assert_equal(0, @num1)
    assert_equal(0, @num2)
  end

=begin
  test "variables are set to expected values after run is called once" do
    @thread.run
    assert_equal(88, @num1)
    assert_equal(0, @num2)
  end

  test "variables are set to expected values after run is called multiple times" do
    2.times{ @thread.run }
    assert_equal(88, @num1)
    assert_equal(99, @num2)
  end
=end

  test "run does not accept any arguments" do
    assert_raise(ArgumentError){ @thread.run(1) }
  end

  def teardown
    @thread.exit
    @thread = nil
  end
end
