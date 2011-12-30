######################################################################
# test_blockdev.rb
#
# Test case for the FileStat#blockdev instance method.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_FileStat_Blockdev_InstanceMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @stat = File::Stat.new(__FILE__)

    if SOLARIS
      @file = '/dev/fd0'
    else
      @file = '/dev/disk0'
    end
  end

  test "blockdev basic functionality" do
    assert_respond_to(@stat, :blockdev?)
  end

  test "blockdev returns expected result" do
    omit_if(WINDOWS, "FileStat#blockdev test skipped on MS Windows")
    assert_false(@stat.blockdev?)
    assert_true(File.stat(@file).blockdev?)
  end

  test "blockdev method does not accept any arguments" do
    assert_raises(ArgumentError){ @stat.blockdev?(1) }
  end

  def teardown
    @stat = nil
    @file = nil
  end
end
