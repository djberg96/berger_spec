######################################################################
# test_euid_set.rb
#
# Test case for the Process.euid= method.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_Process_Euid_Set_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @euid = nil
    @user = Etc.getpwnam('nobody')
  end

  test "euid= basic functionality" do
    assert_respond_to(Process, :euid=)
  end

  test "euid= works as expected" do
    omit_if(WINDOWS, "Process.euid= tests skipped on MS Windows")
    omit_unless(ROOT, "Process.euid= tests skipped unless run as root")

    assert_nothing_raised{ @euid = Process.euid }
    assert_nothing_raised{ Process.euid = @user.gid }
    assert_equal(@user.gid, Process.euid)
    assert_nothing_raised{ Process.euid = @euid }
    assert_equal(@euid, Process.euid)
  end

  test "euid= returns the assigned value" do
    omit_if(WINDOWS, "Process.euid= tests skipped on MS Windows")
    @euid = Process.euid
    assert_equal(@euid, Process.euid = @euid)
  end

  test "euid= requires a numeric argument" do
    omit_if(WINDOWS, "Process.euid= tests skipped on MS Windows")
    assert_raise(TypeError){ Process.euid = "test" }
  end

  def teardown
    @euid = nil
    @user = nil
  end
end
