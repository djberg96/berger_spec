######################################################################
# test_initgroups.rb
#
# Test case for the Process.initgroups module method.
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
    assert_respond_to(Process, :initgroups)
  end

  test "initgroups works as expected with superuser privileges" do
    omit_if(WINDOWS, "Process.initgroups test skipped on MS Windows")
    omit_unless(ROOT, "Process.initgroups test skipped unless run as root.")

    assert_nothing_raised{ Process.initgroups(@login, @groups[0]) }
    assert_kind_of(Array, Process.initgroups(@login, @groups[0]))
  end

  test "initgroups returns an updated array of supplementary groups" do
    omit_if(WINDOWS, "Process.initgroups test skipped on MS Windows")
    omit_unless(ROOT, "Process.initgroups test skipped unless run as root.")

    array = [@groups[0]]
    Etc.group{ |g| array << g.gid if g.mem.include?(@login) }
    assert_equal(array, Process.initgroups(@login, @groups[0]))
  end

  test "initgroups fails as expected without superuser privileges" do
    omit_if(WINDOWS, "Process.initgroups test skipped on MS Windows")
    omit_if(ROOT, "Process.initgroups test skipped when run as root")

    assert_raise(Errno::EPERM){ Process.initgroups(@login, @groups[0]) }
  end

  test "initgroups requires two arguments only" do
    omit_if(WINDOWS, "Process.initgroups test skipped on MS Windows")

    assert_raise(ArgumentError){ Process.initgroups }
    assert_raise(ArgumentError){ Process.initgroups(@login) }
    assert_raise(ArgumentError){ Process.initgroups(@login, 123, 123) }
  end

  def teardown
    @groups = nil
    @login  = nil
  end
end
