######################################################################
# test_setuid.rb
#
# Test case for the FileStat#setuid? instance method.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_FileStat_Setuid_InstanceMethod < Test::Unit::TestCase
  include Test::Helper
   
  def setup
    @stat = File::Stat.new(__FILE__)
    @sudo = `which sudo`.chomp unless WINDOWS
  end

  test "setuid? basic functionality" do
    assert_respond_to(@stat, :setuid?)
  end

  test "setuid? returns expected value" do
    omit_if_windows('setuid?')
    assert_false(@stat.setuid?)
    assert_true(File::Stat.new(@sudo).setuid?)
  end

  test "setuid? does not accept any arguments" do
    assert_raises(ArgumentError){ @stat.setuid?(1) }
  end

  def teardown
    @stat = nil
    @sudo = nil
  end
end
