######################################################################
# test_egid_set.rb
#
# Test case for the Process.egid= method.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_Process_Egid_Set_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @egid = nil
    @user = Etc.getpwnam('nobody')
  end

  test "egid= basic functionality" do
    assert_respond_to(Process, :egid=)
  end

  test "egid= works as expected" do
    omit_if(WINDOWS, "Process.egid= tests skipped on MS Windows")
    omit_unless(ROOT, "Process.egid= tests skipped unless run as root")

    assert_nothing_raised{ @egid = Process.egid }
    assert_nothing_raised{ Process.egid = @user.gid }
    assert_equal(@user.gid, Process.egid)
    assert_nothing_raised{ Process.egid = @egid }
    assert_equal(@egid, Process.egid)
  end

  test "egid= returns the assigned value" do
    omit_if(WINDOWS, "Process.egid= tests skipped on MS Windows")
    @egid = Process.egid
    assert_equal(@egid, Process.egid = @egid)
  end

  test "egid= requires a numeric argument" do
    omit_if(WINDOWS, "Process.egid= tests skipped on MS Windows")
    assert_raise(TypeError){ Process.egid = "test" }
  end

  def teardown
    @egid = nil
    @user = nil
  end
end
