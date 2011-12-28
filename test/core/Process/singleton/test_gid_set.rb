######################################################################
# test_gid_set.rb
#
# Test case for the Process.gid= method. Note that these tests are
# skipped unless run as root on a non-Windows platform.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_Process_GidSet_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    unless WINDOWS
      @local_gid = Etc.getgrnam('staff').gid
      @login_gid = Etc.getpwnam(Etc.getlogin).gid
    end
  end

  test "gid= basic functionality" do
    assert_respond_to(Process, :gid=)
  end

  test "gid= sets the gid as expected" do
    omit_if(WINDOWS, "Process.gid= tests skipped on MS Windows")
    omit_unless(ROOT, "Process.gid= tests skipped except when root")

    assert_nothing_raised{ Process.gid = @local_gid }
    assert_equal(@local_gid, Process.gid)
    assert_nothing_raised{ Process.gid = @login_gid }
    assert_equal(@login_gid, Process.gid)
  end

  test "gid= returns the value that was assigned" do
    omit_if(WINDOWS, "Process.gid= tests skipped on MS Windows")
    omit_unless(ROOT, "Process.gid= tests skipped except when root")

    assert_equal(@local_gid, Process.gid = @local_gid)
  end

  test "gid= requires a numeric argument" do
    omit_unless(ROOT, "Process.gid= tests skipped except when root")
    assert_raises(TypeError){ Process.gid = "bogus" }
  end

  def teardown
    @local_gid = nil
    @login_gid = nil
  end
end
