########################################################################
# test_stat.rb
#
# Test case for the File.stat method.
########################################################################
require 'test/helper'
require 'test-unit'

class TC_File_Stat_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @file = __FILE__
    @stat = nil
    @null = null_device

    unless WINDOWS
      @link = 'link_to_tc_stat.rb'
      File.symlink(__FILE__, @link)
    end
  end

  test "stat basic functionality" do
    assert_respond_to(File, :stat)
  end

  test "stat returns a File::Stat object" do
    assert_nothing_raised{ @stat = File.stat(@file) }
    assert_kind_of(File::Stat, File.stat(@file))
  end

  test "stat object symlink method returns expected result" do
    omit_if(WINDOWS)
    assert_nothing_raised{ @stat = File.stat(@link) }
    assert_false(@stat.symlink?)
  end

  test "calling stat on a null device does not raise an error" do
    assert_nothing_raised{ File.stat(@null) }
  end

  test "stat object instance methods basic functionality" do
    assert_nothing_raised{ @stat = File.stat(@file) }
    assert_respond_to(@stat, :atime)
    assert_respond_to(@stat, :blksize)
    assert_respond_to(@stat, :blockdev?)
    assert_respond_to(@stat, :directory?)
    assert_respond_to(@stat, :size)
  end

  test "an error is raised if the file doesn't exist" do
    assert_raise(Errno::ENOENT){ File.stat('bogus') }
    assert_raise(Errno::ENOENT){ File.stat('') }
  end

  test "stat requires a single argument only" do
    assert_raise(ArgumentError){ File.stat }
    assert_raise(ArgumentError){ File.stat(@file, @file) }
  end

  test "argument to stat must be a string" do
    assert_raise(TypeError){ File.stat(1) }
  end

  def teardown
    unless WINDOWS
      File.delete(@link) if File.exists?(@link)
    end
    @file = nil
    @stat = nil
    @null = nil
  end
end
