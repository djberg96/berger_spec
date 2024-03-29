######################################################################
# test_getpgid.rb
#
# Test case for the Process.getpgid module method.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_Process_Getpgid_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @pid = Process.pid
  end

  test "getpgid basic functionality" do
    omit_if_windows('Process.getpgid')
    assert_respond_to(Process, :getpgid)
    assert_nothing_raised{ Process.getpgid(@pid) }
    assert_kind_of(Integer, Process.getpgid(@pid))
  end

  test "getpgid returns expected results" do
    omit_if_windows('Process.getpgid')
    assert_true(Process.getpgid(@pid) > 0)
    assert_true(Process.getpgid(@pid) < 100000)
  end

  test "getpgid requires one argument" do
    omit_if_windows('Process.getpgid')
    assert_raise(ArgumentError){ Process.getpgid }
    assert_raise(ArgumentError){ Process.getpgid(@pid, @pid) }
  end

  test "getpgid requires a numeric argument" do
    omit_if_windows('Process.getpgid')
    assert_raise(TypeError){ Process.getpgid("test") }
  end

  def teardown
    @pid = nil
  end
end
