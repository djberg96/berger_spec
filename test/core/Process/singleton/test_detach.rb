######################################################################
# test_detach.rb
#
# Test case for the Process.detach method.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_Process_Detach_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @pid  = nil
    @skip = WINDOWS || JRUBY
  end

  test "detach basic functionality" do
    assert_respond_to(Process, :detach)
  end

  test "detach behaves as expected" do
    omit_if(@skip, "Process.detach tests skipped on MS Windows and/or JRuby")
    @pid = fork
    assert_nothing_raised{ Process.detach(@pid) } if @pid
  end

  test "detach requires a single argument" do
    assert_raise(ArgumentError){ Process.detach }
    assert_raise(ArgumentError){ Process.detach(1, 2) }
  end

  test "detach requires a numeric argument" do
    assert_raise(TypeError){ Process.detach("test") }
  end

  def teardown
    Process.kill(9, @pid) rescue nil
    @pid  = nil
    @skip = nil
  end
end
