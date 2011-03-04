######################################################################
# test_maxgroups.rb
#
# Test case for the Process.maxgroups module method.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_Process_Maxgroups_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  test "maxgroups basic functionality" do
    assert_respond_to(Process, :maxgroups)
    assert_nothing_raised{ Process.maxgroups }
    assert_kind_of(Fixnum, Process.maxgroups)
  end

  test "maxgroups returns expected results" do
    assert_equal(32, Process.maxgroups)
  end

  test "maxgroups does not accept any arguments" do
    assert_raise(ArgumentError){ Process.maxgroups(1) }
  end
end
