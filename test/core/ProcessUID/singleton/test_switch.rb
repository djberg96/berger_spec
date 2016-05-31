######################################################################
# test_switch.rb
#
# Test case for the Process::UID.switch module method. Most of these
# tests only run on Unix systems, and then only as root.
#
# Note: I am not convinced that this method actually works, and it
# has unusual (bad) behavior when the euid is the same as the uid.
#
# TODO: Update this as more information becomes available.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_ProcessUID_Switch_ModuleMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @uid  = Process.uid
    @euid = Process.euid
    @user = 'nobody'
  end

  test "switch basic functionality" do
    assert_respond_to(Process::UID, :switch)
  end

  test "switch behaves as expected" do
    omit_if_windows('Process::UID.switch')
    omit_unless_root('Process::UID.switch')
    Process.euid = Etc.getpwnam(@user).uid

    assert_nothing_raised{ Process::UID.switch }
  end

  def teardown
    @uid  = nil
    @euid = nil
    @user = nil
  end
end
