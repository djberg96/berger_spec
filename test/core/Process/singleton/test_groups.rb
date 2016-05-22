######################################################################
# test_groups.rb
#
# Test case for the Process.groups module method.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_Process_Groups_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  test "groups basic functionality" do
    assert_respond_to(Process, :groups)
  end

  test "groups returns the expected results" do
    omit_if_windows('Process.groups')
    assert_kind_of(Array, Process.groups)
    assert_true(Process.groups.size > 0)
  end

  test "the array returned by the groups method contains only integers" do
    omit_if_windows('Process.groups')
    Process.groups.each{ |group| assert_kind_of(Numeric, group) }
  end

  test "groups does not accept any arguments" do
    assert_raises(ArgumentError){ Process.groups(0) }
  end
end
