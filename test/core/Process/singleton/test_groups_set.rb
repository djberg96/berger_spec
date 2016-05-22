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

  test "groups= basic functionality" do
    assert_respond_to(Process, :groups=)
  end

  test "groups= accepts an array of integers" do
    omit_if_windows('Process.groups=')
    omit_unless_root('Process.groups=')

    assert_nothing_raised{ Process.groups = @gids[0..3] }
  end

  test "groups= accepts an array of strings" do
    omit_if_windows('Process.groups=')
    omit_unless_root('Process.groups=')

    assert_nothing_raised{ Process.groups = @names[0..3] }
  end

  test "groups= returns an array of groups that were assigned" do
    omit_if_windows('Process.groups=')
    omit_unless_root('Process.groups=')

    assert_equal(@gids[0..3], Process.groups = @gids[0..3])
    assert_equal(@names[0..3], Process.groups = @names[0..3])
  end

  test "groups= method returns groups that were set" do
    omit_if_windows('Process.groups=')
    omit_if_osx('Process.groups=')
    omit_unless_root('Process.groups=')

    assert_nothing_raised{ Process.groups = @gids[0..3] }
    assert_equal(@gids[0..3], Process.groups)
  end

  test "groups= only accepts an array as an argument" do
    omit_if_windows('Process.groups=')
    omit_unless_root('Process.groups=')

    assert_raises(TypeError){ Process.groups = 'test' }
  end

  test "groups= must contain numbers or strings only" do
    omit_if_windows('Process.groups=')
    omit_unless_root('Process.groups=')

    assert_raises(TypeError){ Process.groups = [true, 1, [], 2] }
  end

  test "groups= raises an error if a group cannot be found for the group name" do
    omit_if_windows('Process.groups=')
    omit_unless_root('Process.groups=')

    assert_raises(ArgumentError){ Process.groups = ["bogusxxx"] }
  end

  test "groups= raises an error without proper permissions" do
    omit_if_root('Process.groups=')
    assert_raises(Errno::EPERM){ Process.groups = [1] }
  end

  def teardown
    @gids   = nil
    @names  = nil
    @groups = nil
  end
end
