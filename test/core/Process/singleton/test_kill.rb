########################################################################
# test_kill.rb
#
# Tests for the Process.kill method
########################################################################
require 'test/helper'

class TC_Process_Kill_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  def self.startup
    @@signals = Signal.list
  end

  def setup
    @ruby = RUBY_PLATFORM == 'java' ? 'jruby' : 'ruby'
    @cmd  = "#{@ruby} -e 'sleep 10'"
    @pid  = nil
  end

  test "kill basic functionality" do
    assert_respond_to(Process, :kill)
  end

  test "kill with signal 0 does not actually send a signal" do
    assert_nothing_raised{ Process.kill(0, 0) }
  end

  test "kill with signal 0 returns 1 if the process exists" do
    assert_equal(1, Process.kill(0, 0))
  end

  test "kill with signal 0 raises an ESRCH error if any process does not exist" do
    assert_raise(Errno::ESRCH){ Process.kill(0, 99999999) }
    assert_raise(Errno::ESRCH){ Process.kill(0, 0, 99999999) }
  end

  test "kill accepts multiple pid values" do
    assert_nothing_raised{ Process.kill(0, 0, 0, 0, 0) }
  end

  test "kill with any signal returns the number of killed processes" do
    pid1 = Process.spawn(@cmd)
    pid2 = Process.spawn(@cmd)
    assert_equal(2, Process.kill(9, pid1, pid2))
  end

  test "kill accepts a string as a signal name" do
    pid = Process.spawn(@cmd)
    assert_nothing_raised{ Process.kill('SIGKILL', pid) }
  end

  test "kill accepts a string without 'SIG' as a signal name" do
    pid = Process.spawn(@cmd)
    assert_nothing_raised{ Process.kill('KILL', pid) }
  end

  test "kill accepts a symbol as a signal name" do
    pid = Process.spawn(@cmd)
    assert_nothing_raised{ Process.kill(:KILL, pid) }
  end

  test "kill coerces the pid to an integer, rounded down" do
    assert_nothing_raised{ Process.kill(0, 0.7) }
  end

  test "the kill method applies to a process group if the signal is negative" do
    pid = Process.spawn(@cmd, :pgroup => true)
    grp = Process.getpgid(pid)
    assert_equal(1, Process.kill(-9, grp))
  end

  test "the kill method applies to a process group if the signal name starts with a minus" do
    pid = Process.spawn(@cmd, :pgroup => true)
    grp = Process.getpgid(pid)
    assert_equal(1, Process.kill('-SIGKILL', grp))
  end

  test "the kill method applies to a process group if the signal name without 'SIG' starts with a minus" do
    pid = Process.spawn(@cmd, :pgroup => true)
    grp = Process.getpgid(pid)
    assert_equal(1, Process.kill('-KILL', grp))
  end

  test "kill requires at least two arguments" do
    assert_raise(ArgumentError){ Process.kill }
  end

  test "the first argument to kill must be an integer or string" do
    assert_raise(ArgumentError){ Process.kill([], 0) }
  end

  test "kill raises an ArgumentError if the signal name is invalid" do
    assert_raise(ArgumentError){ Process.kill("BOGUS", 0) }
  end

  test "kill does not accept lowercase signal names" do
    assert_raise(ArgumentError){ Process.kill("kill", 0) }
  end

  test "kill raises an EINVAL error if the signal number is invalid" do
    assert_raise(Errno::EINVAL){ Process.kill(999999, 0) }
  end

  test "kill raises an TypeError if the pid value is not an integer" do
    assert_raise(TypeError){ Process.kill(0, "BOGUS") }
  end

  test "kill raises an EPERM if user does not have proper privileges" do
    omit_if(Process.uid == 0)
    assert_raise(Errno::EPERM){ Process.kill(9, 1) }
  end

  test "kill raises a SecurityError if $SAFE level is 2 or greater" do
    omit_if(JRUBY)
    assert_raise(SecurityError){
      proc do
        $SAFE = 2
        @pid = Process.spawn(@cmd)
        Process.kill(9, @pid)
      end.call
    }
  end

  test "kill works if the $SAFE level is 1 or lower" do
    omit_if(JRUBY)
    assert_nothing_raised{
      proc do
        $SAFE = 1
        @pid = Process.spawn(@cmd)
        Process.kill(9, @pid)
      end.call
    }
  end

  def teardown
    @cmd  = nil
    @ruby = nil
    Process.kill(9, @pid) if @pid
  end

  def self.teardown
    @@signals = nil
  end
end
