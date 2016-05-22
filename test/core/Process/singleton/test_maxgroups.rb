######################################################################
# test_maxgroups.rb
#
# Test case for the Process.maxgroups module method.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_Process_Maxgroups_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    case RUBY_PLATFORM
      when /darwin/i
        @max = 16
      else
        @max = 32
    end
  end

  test "maxgroups basic functionality" do
    assert_respond_to(Process, :maxgroups)
    assert_nothing_raised{ Process.maxgroups }
    assert_kind_of(Fixnum, Process.maxgroups)
  end

  test "maxgroups returns expected results" do
    if OSX
      assert_equal(@max, Process.maxgroups)
    else
      assert_true(Process.maxgroups > 16)
    end
  end

  test "maxgroups does not accept any arguments" do
    assert_raise(ArgumentError){ Process.maxgroups(1) }
  end

  def teardown
    @max = nil
  end
end
