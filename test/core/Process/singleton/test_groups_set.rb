######################################################################
# test_groups_set.rb
#
# Test case for the Process.groups= module method.
######################################################################
require 'test/helper'
require 'test/unit'
require 'etc'

class TC_Process_GroupsSet_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @groups = []

    Etc.group{ |g| @groups << g } unless WINDOWS

    @gids  = @groups.map{ |e| e.gid if e.gid < 100000 }.compact
    @names = @groups.map{ |e| e.name }
  end

  test "groups_set basic functionality" do
    assert_respond_to(Process, :groups=)
  end

  test "groups_set accepts an array of integers" do
    omit_if(WINDOWS, "Process.groups= test skipped on Windows")
    omit_unless(ROOT, "Process.groups= test skipped unless run as root")
    assert_nothing_raised{ Process.groups = @gids[0..3] }
  end

  test "groups_set accepts an array of strings" do
    omit_if(WINDOWS, "Process.groups= test skipped on Windows")
    omit_unless(ROOT, "Process.groups= test skipped unless run as root")
    assert_nothing_raised{ Process.groups = @names[0..3] }
  end

  test "groups_set returns an array of groups that were assigned" do
    omit_if(WINDOWS, "Process.groups= test skipped on Windows")
    omit_unless(ROOT, "Process.groups= test skipped unless run as root")
    assert_equal(@gids[0..3], Process.groups = @gids[0..3])
    assert_equal(@names[0..3], Process.groups = @names[0..3])
  end

  test "groups_get method returns groups that were set" do
    omit_if(WINDOWS, "Process.groups= test skipped on Windows")
    omit_unless(ROOT, "Process.groups= test skipped unless run as root")
    assert_nothing_raised{ Process.groups = @gids[0..3] }
    assert_equal(@gids[0..3], Process.groups)
  end

  test "groups_set only accepts an array as an argument" do
    omit_if(WINDOWS, "Process.groups= test skipped on Windows")
    assert_raises(TypeError){ Process.groups = 'test' }
  end

  test "groups_set accepts a maximum of 32 groups" do
    omit_if(WINDOWS, "Process.groups= test skipped on Windows")
    arr = (1..33).to_a
    assert_raises(ArgumentError){ Process.groups = arr }
  end

  test "groups_set must contain numbers or strings only" do
    omit_if(WINDOWS, "Process.groups= test skipped on Windows")
    assert_raises(TypeError){ Process.groups = [true, 1, [], 2] }
  end

  test "groups_set raises an error if a group cannot be found for the group name" do
    omit_if(WINDOWS, "Process.groups= test skipped on Windows")
    assert_raises(ArgumentError){ Process.groups = ["bogusxxx"] }
  end

  def teardown
    @gids   = nil
    @names  = nil
    @groups = nil
  end
end
