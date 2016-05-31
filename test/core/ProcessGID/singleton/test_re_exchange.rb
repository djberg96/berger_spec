######################################################################
# test_re_exchange.rb
#
# Test case for the Process::GID.re_exchange module method. This test
# case is useful only if run as root, and only on Linux.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_ProcessGID_ReExchange_ModuleMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @gid  = Process.gid
    @egid = Process.egid
  end

  test "re_exchange basic functionality" do
    assert_respond_to(Process::GID, :re_exchange)
  end

  test "re_exchange returns the expected value" do
    omit_unless_linux('Process::GID.re_exchange')
    assert_nothing_raised{ Process::GID.re_exchange }
    assert_equal(@gid, Process.egid)
    assert_equal(@egid, Process.gid)
  end

  test "re_exchange does not accept any arguments" do
    assert_raises(ArgumentError){ Process::GID.re_exchange(1) }
    assert_raises(ArgumentError){ Process::GID.re_exchange(1, 2) }
  end

  def teardown
    @gid  = nil
    @egid = nil
  end
end
