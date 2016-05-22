######################################################################
# test_getpriority.rb
#
# Test case for the Process.getpriority module method.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_Process_Getpriority_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @kind = Process::PRIO_PROCESS unless WINDOWS
  end

  test "getpriority basic functionality" do
    omit_if_windows('Process.getpriority')
    assert_respond_to(Process, :getpriority)
  end

  test "getpriority returns expected results" do
    omit_if_windows('Process.getpriority')

    assert_kind_of(Fixnum, Process.getpriority(@kind, 0))
    assert_true(Process.getpriority(@kind, Process.pid) >= 0)
    assert_true(Process.getpriority(@kind, Process.pid) <= 100000)
  end

  test "getpriority accepts one of three process types" do
    omit_if_windows('Process.getpriority')

    assert_nothing_raised{ Process.getpriority(Process::PRIO_PGRP, 0) }
    assert_nothing_raised{ Process.getpriority(Process::PRIO_PROCESS, 0) }
    assert_nothing_raised{ Process.getpriority(Process::PRIO_USER, 0) }
  end

  test "getpriority requires two argument" do
    omit_if_windows('Process.getpriority')

    assert_raise(ArgumentError){ Process.getpriority }
    assert_raise(ArgumentError){ Process.getpriority(@kind, 0, 0) }
  end

  test "getpriority requires a valid process type" do
    omit_if_windows('Process.getpriority')
    assert_raise(Errno::EINVAL){ Process.getpriority(9999, 0) }
  end

  test "getpriority requires a numeric process type" do
    omit_if_windows('Process.getpriority')
    assert_raise(TypeError){ Process.getpriority("test", 0) }
  end

  test "getpriority requires a numeric pid" do
    omit_if_windows('Process.getpriority')
    assert_raise(TypeError){ Process.getpriority(@kind, "test") }
  end

  test "getpriority fails at $SAFE level 2 or higher" do
    omit_if_windows('Process.getpriority')
    omit_if_jruby('Process.getpriority with $SAFE')

    assert_raise(SecurityError){
      proc do
        $SAFE = 3
        Process.getpriority(Process::PRIO_PGRP, 0)
      end.call
    }
  end

  test "getpriority works at $SAFE level 1 or lower" do
    omit_if_windows('Process.getpriority')
    omit_if_jruby('Process.getpriority with $SAFE')

    assert_nothing_raised{
      proc do
        $SAFE = 1
        Process.getpriority(Process::PRIO_PGRP, 0)
      end.call
    }
  end

  def teardown
    @kind = nil unless WINDOWS
  end
end
