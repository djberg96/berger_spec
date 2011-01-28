######################################################################
# test_uid.rb
#
# Test case for the Process.uid method.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_Process_Uid_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @uid  = nil
    @user = Etc.getpwnam('nobody')
  end

  test "uid basic functionality" do
    assert_respond_to(Process, :uid)
  end

  test "uid returns the expected results" do
    assert_nothing_raised{ Process.uid }
    assert_kind_of(Fixnum, Process.uid)
    assert_true(Process.uid < 100000)
  end

  test "uid does not accept any arguments" do
    assert_raise(ArgumentError){ Process.uid(1) }
  end

  def teardown
    @uid = nil
    @user = nil
  end
end
