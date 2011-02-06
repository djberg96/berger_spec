######################################################################
# test_egid.rb
#
# Test case for the Process.egid method.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_Process_Egid_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @egid  = nil
    @group = Etc.getgrnam('nobody')
  end

  test "egid basic functionality" do
    assert_respond_to(Process, :egid)
  end

  test "egid returns the expected results" do
    omit_if(WINDOWS, "Process.egid test skipped on MS Windows")
    assert_nothing_raised{ Process.egid }
    assert_kind_of(Fixnum, Process.egid)
    assert_true(Process.egid < 100000)
  end

  test "egid does not accept any arguments" do
    assert_raise(ArgumentError){ Process.egid(1) }
  end

  def teardown
    @egid  = nil
    @group = nil
  end
end
