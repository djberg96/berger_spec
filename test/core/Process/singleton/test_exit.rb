#####################################################################
# test_exit.rb
#
# Test case for the Process.exit module method.
#####################################################################
require 'test/helper'
require 'test/unit'

class TC_Process_Exit_ModuleMethod < Test::Unit::TestCase
  include Test::Helper

  def skip_check
    omit_if(WINDOWS, "exit test skipped on MS Windows")
    omit_if(JAVA, "exit test skipped on Java based platforms")
  end

  test "exit method is defined" do
    assert_respond_to(Process, :exit)
  end

  test "exit returns a default exit status of zero" do
    Process.spawn(RbConfig.ruby, "-e Process.exit")
    _pid, status = Process.wait2
    assert_equal(0, status.exitstatus)
  end

  test "exit with an argument of true returns zero (success)" do
    Process.spawn(RbConfig.ruby, "-e Process.exit(true)")
    _pid, status = Process.wait2
    assert_equal(0, status.exitstatus)
  end

  test "exit with an argument of false returns one (failure)" do
    Process.spawn(RbConfig.ruby, "-e Process.exit(false)")
    _pid, status = Process.wait2
    assert_equal(1, status.exitstatus)
  end

  test "exit accepts and returns the same numeric argument" do
    Process.spawn(RbConfig.ruby, "-e Process.exit(99)")
    _pid, status = Process.wait2
    assert_equal(99, status.exitstatus)
  end

  test "exit requires a true, false or numeric argument" do
    omit_if(WINDOWS, "exit test skipped on MS Windows")
    assert_raise(TypeError){ Process.exit('test') }
  end

  test "exit accepts a maximum of one argument" do
    omit_if(WINDOWS, "exit test skipped on MS Windows")
    assert_raise(ArgumentError){ Process.exit(1, 2) }
  end

  test "exit raises an error in the scope of an exception handler" do
    omit_if(WINDOWS, "exit test skipped on MS Windows")

    begin
      Process.exit(99)
    rescue SystemExit
      x = 'exit_test'
    end

    assert_equal('exit_test', x)
  end

  test "at_exit handlers are invoked when exit is called" do
    skip_check
    reader, writer = IO.pipe

    fork{
      reader.close
      at_exit{ writer.write("at_exit_called") }
      Process.exit
    }

    writer.close
    Process.wait
    assert_equal("at_exit_called", reader.read)
  end

  def teardown
    Process.waitall
  end
end
