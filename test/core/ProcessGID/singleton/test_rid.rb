######################################################################
# tc_rid.rb
#
# Test case for the Process.rid module method. Most tests skipped
# on MS Windows.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_ProcessGID_Rid_ModuleMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    unless WINDOWS
      @gid = Etc.getpwnam(Etc.getlogin).gid
    end
  end

  def test_rid_basic
    assert_respond_to(Process::GID, :rid)
    assert_nothing_raised{ Process::GID.rid }
  end

  def test_rid
    omit_if(WINDOWS, "rid test skipped on MS Windows")
    assert_equal(Process.gid, Process::GID.rid)
    if ROOT
      assert_equal(0, Process::GID.rid)
    else
      assert_equal(@gid, Process::GID.rid)
    end
  end

  def test_rid_expected_errors
    omit_if(WINDOWS, "rid test skipped on MS Windows")
    assert_raises(ArgumentError){ Process::GID.rid(0) }
  end

  def teardown
    unless WINDOWS
      @gid = nil
    end
  end
end
