######################################################################
# test_setgid.rb
#
# Test case for the Process::Sys.setgid module method.
#
# Most of these tests will only run on Unix systems, and then only
# as root.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_ProcessSys_Setgid_ModuleMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @nobody_gid = Etc.getgrnam('nobody').gid
    @login_gid  = Etc.getpwnam(Etc.getlogin).gid
  end

  test "setgid basic" do
    assert_respond_to(Process::Sys, :setgid)
  end

  test "setgid works as expected" do
    omit_unless_root('Process::Sys.setgid')
    omit_if_windows('Process::Sys.setgid')

    assert_nothing_raised{ Process::Sys.setgid(@nobody_gid) }
    assert_equal(@nobody_gid, Process.gid)
    assert_nothing_raised{ Process::Sys.setgid(@login_gid) }
    assert_equal(@login_gid, Process.gid)
  end

  test "setgid raises a NotImplementedError on Windows" do
    omit_unless_windows('Process::Sys.setgid')
    assert_raises(NotImplementedError){ Process::Sys.setgid(1) }
  end

  test "setgid raises an ArgumentError if the group is not found" do
    omit_if_windows('Process::Sys.setgid')
    omit_unless_root('Process::Sys.setgid')
    assert_raises(ArgumentError){ Process::Sys.setgid('bogus') }
  end

  def teardown
    @nobody_gid = nil
    @login_gid  = nil
  end
end
