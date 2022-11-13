######################################################################
# test_detach.rb
#
# Test case for the Process.detach method.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_Process_Detach_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @pid = nil
    @waiter = nil
  end

  test "detach basic functionality" do
    assert_respond_to(Process, :detach)
  end

  test "detach behaves as expected" do
    @pid = Process.spawn(RbConfig.ruby, "sleep 2")
    assert_nothing_raised{ @waiter = Process.detach(@pid) }
    assert_kind_of(Thread, @waiter)
  end

  test "detach requires a single argument" do
    assert_raise(ArgumentError){ Process.detach }
    assert_raise(ArgumentError){ Process.detach(1, 2) }
  end

  test "detach requires a numeric argument" do
    assert_raise(TypeError){ Process.detach("test") }
  end

  def teardown
    Process.kill(9, @pid) rescue nil
    @waiter.join if @waiter
    @pid = nil
    @waiter = nil
  end
end
