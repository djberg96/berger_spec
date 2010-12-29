######################################################################
# tc_re_exchange.rb
#
# Test case for the Process::GID.re_exchange module method. This test
# case is useful only if run as root, and only on Unix systems.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_ProcessGID_ReExchange_ModuleMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    unless WINDOWS
      @gid  = Process.gid
      @egid = Process.egid
    end
  end

  def test_re_exchange_basic
    assert_respond_to(Process::GID, :re_exchange)
  end

  def test_re_exchange
    omit_if(WINDOWS, "re_exchange tests skipped on MS Windows")
    omit_unless(ROOT, "re_exchange tests skipped unless run as root")
    assert_nothing_raised{ Process::GID.re_exchange }
    assert_equal(@gid, Process.egid)
    assert_equal(@egid, Process.gid)
  end

  def test_re_exchange_expected_failures
    assert_raises(ArgumentError){ Process::GID.re_exchange(1) }
    assert_raises(ArgumentError){ Process::GID.re_exchange(1, 2) }
  end

  def teardown
    unless WINDOWS
      @gid  = nil
      @egid = nil
    end
  end
end
