########################################################################
# test_constants.rb
#
# Test case to validate the presence of the various Process constants.
#
# Note that the actual values are not tested because they are set by
# the OS and are not predictable (beyond being numeric).
########################################################################
require 'test/helper'
require 'test/unit'

class TC_Process_Constants < Test::Unit::TestCase
  include Test::Helper

  test "priority constants exist" do
    omit_if(WINDOWS, "Process constant tests skipped on MS Windows")
    assert_not_nil(Process::PRIO_PGRP)
    assert_not_nil(Process::PRIO_PROCESS)
    assert_not_nil(Process::PRIO_USER)
  end

  test "priority constants are numbers" do
    omit_if(WINDOWS, "Process constant tests skipped on MS Windows")
    assert_kind_of(Numeric, Process::PRIO_PGRP)
    assert_kind_of(Numeric, Process::PRIO_PROCESS)
    assert_kind_of(Numeric, Process::PRIO_USER)
  end

  test "child handling constants exist" do
    omit_if(WINDOWS, "child handling constant check skipped on MS Windows")
    assert_not_nil(Process::WNOHANG)
    assert_not_nil(Process::WUNTRACED)
  end

  test "child handling constants are numbers" do
    omit_if(WINDOWS, "child handling constant check skipped on MS Windows")
    assert_kind_of(Numeric, Process::WNOHANG)
    assert_kind_of(Numeric, Process::WUNTRACED)
  end

  test "rlimit constants exist" do
    omit_if(WINDOWS, "rlimit constant check skipped on MS Windows")
    assert_not_nil(Process::RLIM_INFINITY)
    assert_not_nil(Process::RLIM_SAVED_MAX)
    assert_not_nil(Process::RLIM_SAVED_CUR)
    assert_not_nil(Process::RLIMIT_CORE)
    assert_not_nil(Process::RLIMIT_CPU)
    assert_not_nil(Process::RLIMIT_DATA)
    assert_not_nil(Process::RLIMIT_FSIZE)
    assert_not_nil(Process::RLIMIT_NOFILE)
    assert_not_nil(Process::RLIMIT_STACK)
    assert_not_nil(Process::RLIMIT_AS)

    if LINUX || BSD
      assert_not_nil(Process::RLIMIT_MEMLOCK)
      assert_not_nil(Process::RLIMIT_NPROC)
      assert_not_nil(Process::RLIMIT_RSS)
    end

    if BSD
      assert_not_nil(Process::RLIMIT_SBSIZE)
    end
  end

  test "rlimit constants are numbers" do
    omit_if(WINDOWS, "rlimit constant check skipped on MS Windows")
    assert_kind_of(Numeric, Process::RLIM_INFINITY)
    assert_kind_of(Numeric, Process::RLIM_SAVED_MAX)
    assert_kind_of(Numeric, Process::RLIM_SAVED_CUR)
    assert_kind_of(Numeric, Process::RLIMIT_CORE)
    assert_kind_of(Numeric, Process::RLIMIT_CPU)
    assert_kind_of(Numeric, Process::RLIMIT_DATA)
    assert_kind_of(Numeric, Process::RLIMIT_FSIZE)
    assert_kind_of(Numeric, Process::RLIMIT_NOFILE)
    assert_kind_of(Numeric, Process::RLIMIT_STACK)
    assert_kind_of(Numeric, Process::RLIMIT_AS)

    if LINUX || BSD
      assert_kind_of(Numeric, Process::RLIMIT_MEMLOCK)
      assert_kind_of(Numeric, Process::RLIMIT_NPROC)
      assert_kind_of(Numeric, Process::RLIMIT_RSS)
    end

    if BSD
      assert_kind_of(Numeric, Process::RLIMIT_SBSIZE)
    end
  end
end
