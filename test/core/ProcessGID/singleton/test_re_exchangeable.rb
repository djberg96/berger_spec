######################################################################
# test_re_exchangeable.rb
#
# Test case for the Process::GID.re_exchangeable module method.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_ProcessGID_ReExchangeable_ModuleMethod < Test::Unit::TestCase
  include Test::Helper

  test "re_exchangeable? basic functionality" do
    omit_if_windows('Process::GID.re_exchangeable?')
    assert_respond_to(Process::GID, :re_exchangeable?)
    assert_nothing_raised{ Process::GID.re_exchangeable? }
  end

  test "re_exchangeable? returns the expected value" do
    omit_unless_linux('Process::GID.re_exchangeable?')
    assert_true(Process::GID.re_exchangeable?)
  end

  test "re_exchangeable? does not accept any arguments" do
    omit_if_windows('Process::GID.re_exchangeable?')
    assert_raises(ArgumentError){ Process::GID.re_exchangeable?(1) }
    assert_raises(ArgumentError){ Process::GID.re_exchangeable?(1, 2) }
  end
end
