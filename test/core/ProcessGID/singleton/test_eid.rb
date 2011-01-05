######################################################################
# tc_eid.rb
#
# Test case for the Process::GID.eid method. The Process::GID.eid=
# method is part of the tc_grant_privilege test case because its an
# alias for the Process::GID.grant_privilege method.
#
# For now these tests are for Unix platforms only.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_ProcessGID_Eid_ModuleMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @eid   = nil
    @group = Etc.getgrnam('nobody')
  end

  def test_eid_basic
    assert_respond_to(Process::GID, :eid)
  end

  def test_eid
    omit_if(WINDOWS, "eid test skipped on MS Windows")
    assert_nothing_raised{ Process::GID.eid }
    assert_kind_of(Fixnum, Process::GID.eid)
  end

  def teardown
    @eid   = nil
    @group = nil
 end
end
