######################################################################
# test_maxgroups_set.rb
#
# Test case for the Process.maxgroups= module method.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_Process_Maxgroups_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  test "maxgroups_set basic functionality" do
    assert_respond_to(Process, :maxgroups=)
  end

  test "maxgroups_set accepts and returns a numeric argument" do
    assert_nothing_raised{ Process.maxgroups = 64 }
    assert_equal(43, Process.maxgroups = 43)
  end

  test "maxgroups_set maxes out at 4096" do
    assert_nothing_raised{ Process.maxgroups = 10000 }
    assert_equal(4096, Process.maxgroups)
  end

  test "maxgroups_set requires a positive numeric argument" do
    omit_if(WINDOWS, "Process.maxgroups= tests skipped on MS Windows")
    notify("Process.maxgroups= bug; http://redmine.ruby-lang.org/issues/4467")
    assert_raise(TypeError){ Process.maxgroups = "test" }
    assert_raise(TypeError){ Process.maxgroups = -1 }
  end
end
