######################################################################
# tc_grant_privilege.rb
#
# Test case for the Process::GID.grant_privilege module method, along
# with the Process::GID#eid= alias. 
#
# For now these tests are for Unix platforms only.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_ProcessGID_GrantPrivilege_ModuleMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @eid   = nil
    @group = Etc.getgrnam('nobody')
  end

  test "grant_privilege basic functionality" do
    assert_respond_to(Process::GID, :grant_privilege)
  end

  test "eid= is an alias for grant_privilege" do
    assert_respond_to(Process::GID, :eid=)
    assert_alias_method(Process::GID, :eid=, :grant_privilege)
  end

  test "grant_privilege" do
    omit_if(WINDOWS, "grant_privilege tests skipped on MS Windows")
    omit_unless(ROOT, "grant_privilege tests skipped unless run as root")
    assert_nothing_raised{ @eid = Process::GID.eid }
    assert_nothing_raised{ Process::GID.grant_privilege(@group.gid) }
    assert_equal(@group.gid, Process::GID.eid)
    assert_nothing_raised{ Process::GID.grant_privilege(@eid) }
    assert_equal(@eid, Process::GID.eid)
  end

  def teardown
    @eid   = nil
    @group = nil
  end
end
