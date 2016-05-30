######################################################################
# test_seteuid.rb
#
# Test case for the Process::Sys.seteuid module method.
#
# Most of these tests will only run on Unix systems, and then only
# as root.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_ProcessSys_Seteuid_ModuleMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @ruid = Process.uid
    @euid = Process.euid
  end

  def test_seteuid_basic
    assert_respond_to(Process::Sys, :seteuid)
  end

  test "seteuid works as expected" do
    omit_if_windows('Process::Sys.seteuid')
    omit_unless_root('Process::Sys.seteuid')

    assert_nothing_raised{ Process::Sys.seteuid(@ruid) }
    assert_equal(@ruid, Process.euid)
    assert_nothing_raised{ Process::Sys.seteuid(@euid) }
    assert_equal(@euid, Process.euid)
  end

  test "seteuid is not implemented on MS Windows" do
    omit_unless_windows('Process::Sys.seteuid')
    assert_raises(NotImplementedError){ Process::Sys.seteuid(1) }
  end

  test "seteuid raises an ArgumentError if the argument is invalid" do
    omit_if_windows('Process::Sys.seteuid')
    omit_unless_root('Process::Sys.seteuid')
    assert_raises(ArgumentError){ Process::Sys.seteuid('bogus') }
  end

  def teardown
    @ruid = nil
    @euid = nil
  end
end
