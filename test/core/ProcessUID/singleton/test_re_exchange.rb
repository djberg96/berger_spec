######################################################################
# test_re_exchange.rb
#
# Test case for the Process::UID.re_exchange module method. This test
# case is useful only if run as root, and only on Linux.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_ProcessUID_ReExchange_ModuleMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @uid  = Process.uid
    @euid = Process.euid
  end

  test "re_exchange basic functionality" do
    assert_respond_to(Process::UID, :re_exchange)
  end

  test "re_exchange returns the expected value" do
    omit_unless_linux('Process::UID.re_exchange')
    assert_nothing_raised{ Process::UID.re_exchange }
    assert_equal(@uid, Process.euid)
    assert_equal(@euid, Process.uid)
  end

  test "re_exchange does not accept any arguments" do
    assert_raises(ArgumentError){ Process::UID.re_exchange(1) }
    assert_raises(ArgumentError){ Process::UID.re_exchange(1, 2) }
  end

  def teardown
    @uid  = nil
    @euid = nil
  end
end
