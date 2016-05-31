######################################################################
# test_re_exchangeable.rb
#
# Test case for the Process::UID.re_exchangeable module method.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_ProcessUID_ReExchangeable_ModuleMethod < Test::Unit::TestCase
  include Test::Helper

  test "re_exchangeable? basic functionality" do
    omit_if_windows('Process::UID.re_exchangeable?')
    assert_respond_to(Process::UID, :re_exchangeable?)
    assert_nothing_raised{ Process::UID.re_exchangeable? }
  end

  test "re_exchangeable? returns the expected value" do
    omit_if_windows('Process::UID.re_exchangeable?')
    assert_true(Process::UID.re_exchangeable?)
  end

  test "re_exchangeable? does not accept any arguments" do
    omit_if_windows('Process::UID.re_exchangeable?')
    assert_raises(ArgumentError){ Process::UID.re_exchangeable?(1) }
    assert_raises(ArgumentError){ Process::UID.re_exchangeable?(1, 2) }
  end
end
