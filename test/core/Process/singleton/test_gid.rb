######################################################################
# test_gid.rb
#
# Test case for the Process.gid method.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_Process_Gid_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    unless WINDOWS
      @local_gid = Etc.getgrnam('nobody').gid
      @login_gid = Etc.getpwnam(Etc.getlogin).gid
    end
  end

  test "gid basic functionality" do
    assert_respond_to(Process, :gid)
    assert_kind_of(Fixnum, Process.gid)
    assert_true(Process.gid < 100000)
  end

  test "gid returns the expected results" do
    expected = ROOT ? 0 : @login_gid
    assert_equal(expected, Process.gid)
  end

  test "gid does not accept any arguments" do
    assert_raise(ArgumentError){ Process.gid(true) }
  end

  def teardown
    @local_gid = nil
    @login_gid = nil
  end
end
