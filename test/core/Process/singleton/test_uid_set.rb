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
    assert_respond_to(Process, :uid=)
  end

  test "uid= works as expected" do
    omit_if(WINDOWS, "Process.uid= tests skipped on MS Windows")
    omit_unless(ROOT, "Process.uid= tests skipped unless run as root")
    assert_nothing_raised{ Process.uid = @etc.gid }
    assert_equal(@etc.gid, Process.uid)
  end

  test "uid= returns the assigned value" do
    omit_if(WINDOWS, "Process.uid= tests skipped on MS Windows")
    omit_unless(ROOT, "Process.uid= tests skipped unless run as root")
    @uid = Process.uid
    assert_equal(@uid, Process.uid = @uid)
  end

  test "uid= accepts an a string argument" do
    omit_if(WINDOWS, "Process.uid= tests skipped on MS Windows")
    omit_unless(ROOT, "Process.uid= tests skipped unless run as root")
    assert_nothing_raised{ Process.uid = 'nobody' }
  end

  test "uid= requires a valid user" do
    omit_if(WINDOWS, "Process.uid= tests skipped on MS Windows")
    omit_unless(ROOT, "Process.uid= tests skipped unless run as root")
    assert_raise(ArgumentError){ Process.uid = "bogus" }
  end

  def teardown
    @uid = nil
    @etc = nil
  end
end
