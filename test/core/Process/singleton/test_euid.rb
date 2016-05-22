######################################################################
# test_euid.rb
#
# Test case for the Process.euid method.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_Process_Euid_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @euid = nil
    @user = Etc.getpwnam('nobody')
  end

  test "euid basic functionality" do
    assert_respond_to(Process, :euid)
  end

  test "euid returns the expected results" do
    assert_nothing_raised{ Process.euid }
    assert_kind_of(Fixnum, Process.euid)
    assert_true(Process.euid < 100000)
  end

  test "euid does not accept any arguments" do
    assert_raise(ArgumentError){ Process.euid(1) }
  end

  def teardown
    @euid = nil
    @user = nil
  end
end
