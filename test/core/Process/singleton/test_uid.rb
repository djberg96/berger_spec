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
    @etc = Etc.getpwnam(ENV['USER'])
  end

  test "uid basic functionality" do
    assert_respond_to(Process, :uid)
    assert_nothing_raised{ Process.uid }
    assert_kind_of(Fixnum, Process.uid)
  end

  test "uid returns the expected results" do
    assert_true(Process.uid == @etc.uid)
  end

  test "uid does not accept any arguments" do
    assert_raise(ArgumentError){ Process.uid(1) }
  end

  def teardown
    @uid = nil
    @etc = nil
  end
end
