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
    omit_if_windows('Process.egid=')
    assert_respond_to(Process, :egid=)
  end

  test "egid= works as expected" do
    omit_if_windows('Process.egid=')
    omit_unless_root('Process.egid=')

    @egid = Process.egid
    assert_nothing_raised{ Process.egid = @user.gid }
    assert_equal(@user.gid, Process.egid)

    assert_nothing_raised{ Process.egid = @egid }
    assert_equal(@egid, Process.egid)
  end

  test "egid= returns the assigned value" do
    omit_if_windows('Process.egid=')
    @egid = Process.egid
    assert_equal(@egid, Process.egid = @egid)
  end

  test "egid= requires a valid argument" do
    omit_if_windows('Process.egid=')
    assert_raise(ArgumentError){ Process.egid = "bogus" }
  end

  def teardown
    @egid = nil
    @user = nil
  end
end
