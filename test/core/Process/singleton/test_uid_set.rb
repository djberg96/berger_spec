######################################################################
# test_uid_set.rb
#
# Test case for the Process.uid= method.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_Process_Uid_Set_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @uid = nil
    @user = Etc.getpwnam('nobody')
  end

  test "uid= basic functionality" do
    assert_respond_to(Process, :uid=)
  end

  test "uid= works as expected" do
    omit_if(WINDOWS, "Process.uid= tests skipped on MS Windows")
    omit_unless(ROOT, "Process.uid= tests skipped unless run as root")

    assert_nothing_raised{ @uid = Process.uid }
    assert_nothing_raised{ Process.uid = @user.gid }
    assert_equal(@user.gid, Process.uid)
    assert_nothing_raised{ Process.uid = @uid }
    assert_equal(@uid, Process.uid)
  end

  test "uid= returns the assigned value" do
    omit_if(WINDOWS, "Process.uid= tests skipped on MS Windows")
    @uid = Process.uid
    assert_equal(@uid, Process.uid = @uid)
  end

  test "uid= requires a numeric argument" do
    omit_if(WINDOWS, "Process.uid= tests skipped on MS Windows")
    assert_raise(TypeError){ Process.uid = "test" }
  end

  def teardown
    @uid = nil
    @user = nil
  end
end
