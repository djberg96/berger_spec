########################################################################
# test_lstat.rb
#
# Test case for the File.lstat method.
########################################################################
require 'test/helper'
require 'test-unit'

class TC_File_Lstat_ClassMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @file  = __FILE__
    @lstat = nil
    @null  = null_device

    unless WINDOWS
      @link = 'link_to_tc_lstat.rb'
      File.symlink(__FILE__, @link)
    end
  end

  test "lstat basic functionality" do
    assert_respond_to(File, :lstat)
  end

  test "lstat returns File::Stat object" do
    assert_nothing_raised{ @lstat = File.lstat(@file) }
    assert_kind_of(File::Stat, File.lstat(@file))
  end

  test "lstat returns info on symlinked file if link" do
    omit_if(WINDOWS)
    assert_nothing_raised{ @lstat = File.lstat(@link) }
    assert_equal(true, @lstat.symlink?)
  end

  test "lstat on null device does not raise an error" do
    assert_nothing_raised{ File.lstat(@null) }
  end

  test "stat object returned by lstat method contains expected members" do
     assert_nothing_raised{ @lstat = File.lstat(@file) }
     assert_respond_to(@lstat, :atime)
     assert_respond_to(@lstat, :blksize)
     assert_respond_to(@lstat, :blockdev?)
     assert_respond_to(@lstat, :directory?)
     assert_respond_to(@lstat, :size)
  end

  test "lstat raises an error if the file does not exist" do
     assert_raise(Errno::ENOENT){ File.lstat('bogus') }
     assert_raise(Errno::ENOENT){ File.lstat('') }
  end

  test "lstat requires one argument" do
     assert_raise(ArgumentError){ File.lstat }
     assert_raise(ArgumentError){ File.lstat(@file, @file) }
  end

  test "argument to lstat must be a string" do
     assert_raise(TypeError){ File.lstat(1) }
  end

  def teardown
    unless WINDOWS
      File.delete(@link) if File.exist?(@link)
    end
    @file = nil
    @lstat = nil
    @null = nil
  end
end
