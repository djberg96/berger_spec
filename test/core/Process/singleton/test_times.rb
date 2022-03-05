######################################################################
# test_times.rb
#
# Test case for the Process.times module method.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_Process_Times_ModuleMethod < Test::Unit::TestCase
  test "times basic functionality" do
    assert_respond_to(Process, :times)
    assert_kind_of(Process::Tms, Process.times)
  end

  test "times does not accept an argument" do
    assert_raises(ArgumentError){ Process.times(0) }
  end
end
