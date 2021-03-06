######################################################################
# test_change_privilege.rb
#
# Test case for the Process::UID.change_privilege module method.
#
# NOTE: Most tests will only run with root privileges, and then only
# on Unix systems.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_ProcessUID_ChangePrivilege_ModuleMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @ruid = Process.uid
    @euid = Process.euid
  end

  test "change_privilege basic functionality" do
    omit_if_windows('Process::UID.change_privilege')
    assert_respond_to(Process::UID, :change_privilege)
  end

  test "change_privilege works as expected" do
    omit_if_windows('Process::UID.change_privilege')
    omit_unless_root('Process::UID.change_privilege')

    assert_nothing_raised{ Process::UID.change_privilege(@euid) }
    assert_equal(@euid, Process::UID.eid)
    assert_nothing_raised{ Process::UID.change_privilege(@ruid) }
    assert_equal(@ruid, Process::UID.eid)
  end

  test "change_privilege is not supported on MS Windows" do
    omit_unless_windows('Process::UID.change_privilege')
    assert_raises(NotImplementedError){ Process::UID.change_privilege("x") }
  end

  test "change_privilege raises an error if the argument is invalid" do
    assert_raises(ArgumentError){ Process::UID.change_privilege("x") }
  end

  def teardown
    @euid = nil
    @ruid = nil
  end
end
