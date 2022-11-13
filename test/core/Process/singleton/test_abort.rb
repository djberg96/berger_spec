#####################################################################
# test_abort.rb
#
# Test case for the Process.abort module method. I have no idea
# how to properly test this without a fork() function on MS Windows.
#####################################################################
require 'test/helper'
require 'test/unit'

class TC_Process_Abort_ModuleMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @skip   = WINDOWS || JAVA
    @stderr = STDERR.clone
    @file   = File.join(Dir.pwd, 'test_abort.txt')
    @fh     = File.open(@file, "w")
    STDERR.reopen(@fh)
  end

  test "abort basic functionality" do
    assert_respond_to(Process, :abort)
  end

  test "abort behaves as expected" do
    omit_if(@skip, "Process.abort tests skipped on MS Windows and/or JRuby")
    fork{ Process.abort }
    _,status = Process.wait2
    assert_equal(1, status.exitstatus)
  end

  test "abort accepts and returns a message" do
    omit_if(@skip, "Process.abort tests skipped on MS Windows and/or JRuby")
    fork{ Process.abort("hello world") }
    _,status = Process.wait2
    assert_equal(1, status.exitstatus)
    assert_equal("hello world", IO.read(@file).chomp)
  end

  test "abort only accepts one argument" do
    assert_raise(ArgumentError){ Process.abort("test", "test2") }
  end

  test "abort only accepts string arguments" do
    assert_raise(TypeError){ Process.abort(1234) }
  end

  def teardown
    @fh.close if @fh && !@fh.closed?
    STDERR.reopen(@stderr)
    File.delete(@file) if File.exist?(@file)
  end
end
