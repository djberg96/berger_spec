######################################################################
# test_maxgroups_set.rb
#
# Test case for the Process.maxgroups= module method.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_Process_MaxgroupsSet_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    case RUBY_PLATFORM
      when /darwin/i
        @max = 16
      else
        @max = 4096
    end
  end

  test "maxgroups= basic functionality" do
    omit_if_windows('Process.maxgroups=')
    assert_respond_to(Process, :maxgroups=)
  end

  test "maxgroups= accepts and returns a numeric argument" do
    omit_if_windows('Process.maxgroups=')
    assert_nothing_raised{ Process.maxgroups = 64 }
    assert_equal(43, Process.maxgroups = 43)
  end

  test "maxgroups= requires a positive numeric argument" do
    omit_if(WINDOWS, "Process.maxgroups= tests skipped on MS Windows")
    assert_raise(TypeError){ Process.maxgroups = "test" }
    assert_raise(ArgumentError){ Process.maxgroups = -1 }
  end

  def teardown
    @max = nil
  end
end
