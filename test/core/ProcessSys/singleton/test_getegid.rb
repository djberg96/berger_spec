######################################################################
# tc_getegid.rb
#
# Test case for the Process::Sys.getegid module method.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_ProcessSys_Getegid_ModuleMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @egid = Process.egid
  end

  test "getegid basic functionality" do
    assert_respond_to(Process::Sys, :getegid)
    assert_nothing_raised{ Process::Sys.getegid }
  end

  test "getegid returns the expected results" do
    assert_equal(@egid, Process::Sys.getegid)
  end

  test "getegid does not accept any arguments" do
    assert_raises(ArgumentError){ Process::Sys.getegid(1) }
  end

  def teardown
    @egid = nil
  end
end
