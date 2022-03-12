######################################################################
# test_pid.rb
#
# Test case for the Process.pid module method. It also tests the $$
# special variable.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_Process_Pid_ModuleMethod < Test::Unit::TestCase
  test "pid basic functionality" do
    assert_respond_to(Process, :pid)
    assert_kind_of(Integer, Process.pid)
  end

  test "pid global variable is set to the expected value" do
    assert_kind_of(Integer, $$)
    assert_equal(Process.pid, $$)
  end
end
