#####################################################################
# test_exit_bang.rb
#
# Test case for the Process.exit! method. I have no idea how
# to properly test this on MS Windows without a fork() method.
#####################################################################
require 'test/helper'
require 'test/unit'

class TC_Process_ExitBang_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  def skip_check
    omit_if(WINDOWS, "exit test skipped on MS Windows")
    omit_if(JAVA, "exit test skipped on Java based platforms")
  end

  test "exit bang method is defined" do
    assert_respond_to(Process, :exit!)
  end

  test "exit bang returns a default exit status of one" do
    skip_check
    fork{ Process.exit! }
    _,status = Process.wait2
    assert_equal(1, status.exitstatus)
  end

  test "exit bang with an argument of true returns zero (success)" do
    skip_check
    fork{ Process.exit!(true) }
    _,status = Process.wait2
    assert_equal(0, status.exitstatus)
  end

  test "exit bang with an argument of false returns one (failure)" do
    skip_check
    fork{ Process.exit!(false) }
    _,status = Process.wait2
    assert_equal(1, status.exitstatus)
  end

  test "exit bang accepts and returns the same numeric argument" do
    skip_check
    fork{ Process.exit!(99) }
    _,status = Process.wait2
    assert_equal(99, status.exitstatus)
  end

  test "exit bang requires a true, false or numeric argument" do
    omit_if(WINDOWS, "exit test skipped on MS Windows")
    assert_raise(TypeError){ Process.exit!('test') }
  end

  test "exit bang accepts a maximum of one argument" do
    omit_if(WINDOWS, "exit test skipped on MS Windows")
    assert_raise(ArgumentError){ Process.exit!(1, 2) }
  end

  test "exit_bang cannot be rescued" do
    skip_check
    reader, writer = IO.pipe
    fork{
      reader.close
      begin
        Process.exit!(99)
      rescue SystemExit
        writer.write 'exit_bang_test'
      end
    }
    Process.wait
    writer.close
    assert_equal('', reader.read)
    reader.close
  end

  test "at_exit handlers are skipped when exit_bang is called" do
    skip_check
    reader, writer = IO.pipe
    fork{
      reader.close
      at_exit{ writer.write("at_exit_called") }
      writer.close
      Process.exit!
    }

    writer.close
    Process.wait

    assert_equal('', reader.read)

    reader.close
  end

  def teardown
    Process.waitall unless WINDOWS || JRUBY
  end
end
