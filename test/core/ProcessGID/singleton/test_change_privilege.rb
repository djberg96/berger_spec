######################################################################
# test_change_privilege.rb
#
# Test case for the Process::GID.change_privilege module method.
#
# NOTE: Most tests will only run with root privileges, and then only
# on Unix systems.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_ProcessGID_ChangePrivilege_ModuleMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @rgid = Process.gid
    @egid = Process.egid
  end

  test "change_privilege basic functionality" do
    omit_if_windows('Process::GID.change_privilege')
    assert_respond_to(Process::GID, :change_privilege)
  end

  test "change_privilege works as expected" do
    omit_if_windows('Process::GID.change_privilege')
    omit_unless_root('Process::GID.change_privilege')

    assert_nothing_raised{ Process::GID.change_privilege(@egid) }
    assert_equal(@egid, Process::GID.eid)
    assert_nothing_raised{ Process::GID.change_privilege(@rgid) }
    assert_equal(@rgid, Process::GID.eid)
  end

  test "change_privilege is not supported on MS Windows" do
    omit_unless_windows('Process::GID.change_privilege')
    assert_raises(NotImplementedError){ Process::GID.change_privilege("x") }
  end

  test "change_privilege raises an error if the argument is invalid" do
    assert_raises(ArgumentError){ Process::GID.change_privilege("x") }
  end

  def teardown
    @egid = nil
    @rgid = nil
  end
end
