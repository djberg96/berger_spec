######################################################################
# tc_change_privilege.rb
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
    unless WINDOWS
      @nobody_gid = Etc.getgrnam('nobody').gid
      @login_gid  = Etc.getpwnam(Etc.getlogin).gid
    end
  end

  def test_change_privilege_basic
    omit_if(WINDOWS, "change_privilege test skipped on MS Windows")
    assert_respond_to(Process::GID, :change_privilege)
  end

  def test_change_privilege
    omit_if(WINDOWS, "change_privilege tests skipped on MS Windows")
    omit_unless(ROOT, "change_privilege test skipped unless run as root")
    assert_nothing_raised{ Process::GID.change_privilege(@nobody_gid) }
    assert_equal(@nobody_gid, Process::GID.eid)
    assert_nothing_raised{ Process::GID.change_privilege(@login_gid) }
    assert_equal(@login_gid, Process::GID.eid)
  end

  def test_gid_expected_errors
    assert_raises(TypeError){ Process::GID.change_privilege("x") }
  end

  def teardown
    unless WINDOWS
       @nobody_gid = nil
       @login_gid  = nil
    end
  end
end
