##########################################################################
# test_chown.rb
#
# Test suite for the File.chown? class method. These tests are skipped
# on MS Windows.
#
# On UNIX systems, I require the 'etc' package in order to get a user and
# group that I can use.
#
# This test case is somewhat complicated by the fact that the
# restrictions on File.chown vary from platform to platform, with
# some platforms allowing configuration via the _POSIX_CHOWN_RESTRICTED
# constant in unistd.h.
#
# For now, I'll follow the typical restriction found on most systems,
# i.e. that you must be root to successfully chown a file. Thus, it is
# best if you run this test case as root. If not, some tests will be
# skipped.
##########################################################################
require 'test/helper'
require 'test/unit'
require 'etc'

class TC_File_Chown_ClassMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    unless WINDOWS
      @file1 = "temp1.txt"
      @file2 = "temp2.txt"
      @root  = Process.euid == 0
      @uid   = Etc.getpwnam('nobody').uid
      @gid   = Etc.getgrnam('nobody').gid
      touch(@file1)
      touch(@file2)
    end
  end

  test "chown basic functionality" do
    omit_if(WINDOWS)
    assert_respond_to(File, :chown)
    assert_nothing_raised{ File.chown(-1, -1, @file1) }
    assert_kind_of(Numeric, File.chown(-1, -1, @file1))
  end

  test "chown does not complain if no files are provided" do
    omit_if(WINDOWS)
    assert_nothing_raised{ File.chown(-1, -1) }
    assert_equal(0, File.chown(-1, -1))
  end

  test "chown ignores nil or -1 arguments" do
    omit_if(WINDOWS)
    assert_equal(1, File.chown(-1, -1, @file1))
    assert_equal(1, File.chown(nil, nil, @file1))
    assert_equal(1, File.chown(-1, nil, @file1))
    assert_equal(1, File.chown(nil, -1, @file1))
  end

  test "chown works as expected" do
    omit_if(WINDOWS)
    omit_unless(@root)
    assert_equal(1, File.chown(@uid, -1, @file1))
    assert_equal(1, File.chown(-1, @gid, @file1))
    assert_equal(1, File.chown(@uid, @gid, @file1))
    assert_equal(2, File.chown(@uid, @gid, @file1, @file2))
  end


  test "chown requires at least two arguments" do
    omit_if(WINDOWS)
    assert_raises(ArgumentError){ File.chown(-1) }
  end

  test "first two arguments to chown must be numeric if not nil" do
    omit_if(WINDOWS)
    assert_raises(TypeError){ File.chown('bogus', -1) }
    assert_raises(TypeError){ File.chown(-1, 'bogus') }
  end

  def teardown
    unless WINDOWS
      File.delete(@file1) if File.exist?(@file1)
      File.delete(@file2) if File.exist?(@file2)

      @file = nil
      @root = nil
      @uid  = nil
      @gid  = nil
    end
  end
end
