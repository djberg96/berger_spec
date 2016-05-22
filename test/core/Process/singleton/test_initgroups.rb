######################################################################
# test_initgroups.rb
#
# Test case for the Process.initgroups module method. Skipped on
# Windows and some tests skipped on OSX. The OSX implementation is
# non-standard and a pain to test.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_Process_Initgroups_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @groups = []
    @login  = Etc.getlogin
    Etc.group{ |g| @groups << g.gid }
  end

  test "initgroups basic functionality" do
    omit_if_windows('Process.initgroups')
    assert_respond_to(Process, :initgroups)
  end

  test "initgroups works as expected with superuser privileges" do
    omit_if_windows('Process.initgroups')
    omit_unless_root('Process.initgroups')

    assert_nothing_raised{ Process.initgroups(@login, @groups[0]) }
    assert_kind_of(Array, Process.initgroups(@login, @groups[0]))
  end

  test "initgroups returns an updated array of supplementary groups" do
    omit_if_windows('Process.initgroups')
    omit_if_osx('Process.initgroups')
    omit_unless_root('Process.initgroups')

    array = [@groups[0]]
    Etc.group{ |g| array << g.gid if g.mem.include?(@login) }
    assert_equal(array, Process.initgroups(@login, @groups[0]))
  end

  test "initgroups fails as expected without superuser privileges" do
    omit_if_windows('Process.initgroups')
    omit_if_root('Process.initgroups')

    assert_raise(Errno::EPERM){ Process.initgroups(@login, @groups[0]) }
  end

  test "initgroups requires two arguments only" do
    omit_if_windows('Process.initgroups')

    assert_raise(ArgumentError){ Process.initgroups }
    assert_raise(ArgumentError){ Process.initgroups(@login) }
    assert_raise(ArgumentError){ Process.initgroups(@login, 123, 123) }
  end

  def teardown
    @groups = nil
    @login  = nil
  end
end
