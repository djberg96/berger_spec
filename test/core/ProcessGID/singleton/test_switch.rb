######################################################################
# test_switch.rb
#
# Test case for the Process::GID.switch module method. Most of these
# tests only run on Unix systems, and then only as root.
#
# Note: I am not convinced that this method actually works, and it
# has unusual (bad) behavior when the euid is the same as the uid.
#
# TODO: Update this as more information becomes available.
######################################################################
require 'test/helper'
require 'test/unit'
require 'etc'

class TC_ProcessGID_Switch_ModuleMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @gid  = Process.gid
    @egid = Process.egid
    @group = 'nobody'
  end

  test "switch basic functionality" do
    assert_respond_to(Process::GID, :switch)
  end

  test "switch behaves as expected" do
    omit_if_windows('Process::GID.switch')
    omit_unless_root('Process::GID.switch')
    Process.egid = Etc.getgrnam(@group).gid

    assert_nothing_raised{ Process::GID.switch }
  end

  def teardown
    if ROOT && !WINDOWS
      Process.egid = @gid
    end

    @gid  = nil
    @egid = nil
    @group = nil
  end
end
