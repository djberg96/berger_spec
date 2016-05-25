######################################################################
# tc_setegid.rb
#
# Test case for the Process::Sys.setegid module method.
#
# Most of these tests will only run on Unix systems, and then only
# as root.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_ProcessSys_Setegid_ModuleMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @nobody_gid = Etc.getgrnam('nobody').gid
    @login_gid  = Etc.getpwnam(Etc.getlogin).gid
  end

  test "setegid basic functionality" do
    assert_respond_to(Process::Sys, :setegid)
  end

  test "setegid works as expected" do
    omit_unless_root('Process::Sys.getegid')
    assert_nothing_raised{ Process::Sys.setegid(@nobody_gid) }
    assert_equal(@nobody_gid, Process.egid)
    assert_nothing_raised{ Process::Sys.setegid(@login_gid) }
    assert_equal(@login_gid, Process.egid)
  end

  test "setegid raises an error if the argument is invalid" do
    omit_if_windows('Process::Sys.setegid')
    assert_raises(ArgumentError){ Process::Sys.setegid('bogus') }
  end

  test "setegid requires a single argument" do
    omit_if_windows('Process::Sys.setegid')
    assert_raises(ArgumentError){ Process::Sys.setegid }
    assert_raises(ArgumentError){ Process::Sys.setegid(1,2) }
  end

  test "setegid is not implemented on Windows" do
    omit_unless_windows('Process::Sys.setegid')
    assert_raises(NotImplementedError){ Process::Sys.setegid('bogus') }
  end

  def teardown
    @nobody_gid = nil
    @login_gid  = nil
  end
end
