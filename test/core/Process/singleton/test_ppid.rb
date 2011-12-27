######################################################################
# test_ppid.rb
#
# Test case for the Process.ppid module method.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_Process_Ppid_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  test "ppid basic functionality" do
    assert_respond_to(Process, :ppid)
    assert_nothing_raised{ Process.ppid }
    assert_kind_of(Fixnum, Process.ppid)
  end

  test "ppid returns expected results" do
    omit_if(WINDOWS, "Process.ppid broken on MS Windows")
    assert_true(Process.ppid < Process.pid)
    assert_true(Process.ppid > 0)
  end

  test "ppid does not accept any arguments" do
    assert_raise(ArgumentError){ Process.ppid(1) }
  end
end
