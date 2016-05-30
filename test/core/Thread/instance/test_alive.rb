########################################################################
# test_alive.rb
#
# Test case for the Thread#alive? instance method.
########################################################################
require 'test/helper'
require 'test/unit'

class TC_Thread_Alive_InstanceMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @thread = Thread.new{ sleep 1 while true }
  end

  test "alive? basic functionality" do
    assert_respond_to(@thread, :alive?)
    assert_boolean(@thread.alive?)
  end

  test "alive? returns expected results" do
    assert_true(@thread.alive?)
    @thread.exit; sleep 0.1
    assert_false(@thread.alive?)
  end

  test "alive? does not accept any arguments" do
    assert_raise(ArgumentError){ @thread.alive?(true) }
  end

  def teardown
    @thread.exit
    @thread = nil
  end
end
