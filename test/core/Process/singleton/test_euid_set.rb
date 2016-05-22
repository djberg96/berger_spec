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
    omit_if_windows('Process.euid=')
    assert_respond_to(Process, :euid=)
  end

  test "euid= works as expected" do
    omit_if_windows('Process.euid=')
    omit_unless_root('Process.euid=')

    @euid = Process.euid
    assert_nothing_raised{ Process.euid = @user.gid }
    assert_equal(@user.gid, Process.euid)

    assert_nothing_raised{ Process.euid = @euid }
    assert_equal(@euid, Process.euid)
  end

  test "euid= returns the assigned value" do
    omit_if_windows('Process.euid=')
    @euid = Process.euid
    assert_equal(@euid, Process.euid = @euid)
  end

  test "euid= requires a valid user" do
    omit_if_windows('Process.euid=')
    assert_raise(ArgumentError){ Process.euid = "bogus" }
  end

  def teardown
    @euid = nil
    @user = nil
  end
end
