######################################################################
# test_grpowned.rb
#
# Test case for the FileStat#grpowned? instance method.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_FileStat_GrpOwned_InstanceMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @file = 'grpowned_test.txt'
    touch(@file)

    @stat = File::Stat.new(@file)

    if WINDOWS
      @user = nil
      @bool = nil
    else
      @user = Etc.getpwnam(Etc.getlogin)
      @bool = Etc.getgrgid(@user.gid).name == @user.name
      @bool = true if ROOT || OSX
    end
  end

  test "grpowned basic functionality" do
    assert_respond_to(@stat, :grpowned?)
    assert_boolean(@stat.grpowned?)
  end

  test "grpowned always returns false on Windows" do
    omit_unless(WINDOWS, 'grpowned test skipped except on Windows')
    assert_false(@stat.grpowned?)
  end

  test "grpowned returns the expected results on Unix" do
    omit_if(WINDOWS, 'grpowned test skipped on Windows')
    assert_true(@stat.grpowned?)
    assert_equal(@bool, File::Stat.new('/').grpowned?)
  end

  test "grpowned does not take any arguments" do
    assert_raises(ArgumentError){ @stat.grpowned?(1) }
  end

  def teardown
    File.delete(@file) if File.exists?(@file)

    @stat = nil
    @bool = nil
    @user = nil
    @file = nil
  end
end
