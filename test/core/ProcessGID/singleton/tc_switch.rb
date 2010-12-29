######################################################################
# tc_switch.rb
#
# Test case for the Process::GID.switch module method. Most of these
# tests only run on Unix systems, and then only as root.
#
# Note: I am not convinced that this method actually works, and it
# has unusual (bad) behavior when the egid is the same as the gid.
#
# TODO: Update this as more information becomes available.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_ProcessGID_Switch_ModuleMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @gid  = Process.gid
    @egid = Process.egid

    if ROOT && !WINDOWS && @gid == @egid
      Process.egid = Etc.getgrnam('nobody').gid
      @egid = Process.egid
    end
  end

  def test_switch_basic
    assert_respond_to(Process::GID, :switch)
  end

  def test_switch
    notify("switch tests unfinished until correct behavior can be determined")
    omit_if(WINDOWS, "switch tests skipped on MS Windows")
    omit_unless(ROOT, "switch tests skipped unless run as root")
    assert_nothing_raised{ Process::GID.switch }
    #assert_equal(@egid, Process.gid)
    #assert_equal(@gid, Process.egid)
  end

  def test_switch_with_block
    pend("switch_with_block tests pending")
  end

  def teardown
    @gid  = nil
    @egid = nil
  end
end
