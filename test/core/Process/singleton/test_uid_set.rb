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
    @etc = Etc.getpwnam(ENV['USER'])
  end

  test "uid= basic functionality" do
    omit_if_windows('Process.uid=')
    assert_respond_to(Process, :uid=)
  end

  test "uid= works as expected" do
    omit_if_windows('Process.uid=')
    omit_unless_root('Process.uid=')
    assert_nothing_raised{ Process.uid = @etc.gid }
    assert_equal(@etc.gid, Process.uid)
  end

  test "uid= returns the assigned value" do
    omit_if_windows('Process.uid=')
    omit_unless_root('Process.uid=')
    @uid = Process.uid
    assert_equal(@uid, Process.uid = @uid)
  end

  test "uid= accepts an a string argument" do
    omit_if_windows('Process.uid=')
    omit_unless_root('Process.uid=')
    assert_nothing_raised{ Process.uid = 'nobody' }
  end

  test "uid= requires a valid user" do
    omit_if_windows('Process.uid=')
    omit_unless_root('Process.uid=')
    assert_raise(ArgumentError){ Process.uid = "bogus" }
  end

  test "uid= raises an error without proper privileges" do
    omit_if_root('Process.uid=')
    assert_raise(Errno::EPERM){ Process.uid = 0 }
  end

  def teardown
    @uid = nil
    @etc = nil
  end
end
