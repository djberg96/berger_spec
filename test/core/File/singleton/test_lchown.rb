##########################################################################
# test_lchown.rb
#
# Test suite for the File.lchown? class method. These tests are skipped
# on most platforms.
##########################################################################
require 'test/helper'
require 'test/unit'
require 'mkmf/lite'

class TC_File_Lchown_ClassMethod < Test::Unit::TestCase
  include Test::Helper
  extend Mkmf::Lite

  def self.startup
    @@lchown_support = have_func("lchown")
    @@lchown_message = "lchown not supported on this platform"
  end

  def setup
    if @@lchown_support
      @file1 = "temp1.txt"
      @file2 = "temp2.txt"
      @link1 = "temp1.link"
      @link2 = "temp2.link"
      touch(@file1)
      touch(@file2)
      File.symlink(@file1, @link1)
      File.symlink(@file2, @link2)
      @uid = Etc.getpwnam('nobody').uid rescue Etc.getpwnam(Etc.getlogin).uid
      @gid = Etc.getgrnam('nobody').gid rescue Etc.getgrnam('users').gid
    end
  end

  test "lchown basic functionality" do
    omit_unless(@@lchown_support, @@lchown_message)
    assert_respond_to(File, :lchown)
    assert_nothing_raised{ File.lchown(-1, -1, @link1) }
    assert_kind_of(Integer, File.lchown(-1, -1, @link1))
  end

  test "lchown ignores -1 or nil arguments" do
    omit_unless(@@lchown_support, @@lchown_message)
    assert_equal(1, File.lchown(-1, -1, @link1))
    assert_equal(1, File.lchown(nil, -1, @link1))
    assert_equal(1, File.lchown(-1, nil, @link1))
    assert_equal(1, File.lchown(nil, nil, @link1))
  end

  test "lchown works as expected with root privileges" do
    omit_unless(@@lchown_support, @@lchown_message)
    omit_unless(ROOT, "lchown tests skipped unless run as root")
    assert_equal(1, File.lchown(@uid, -1, @link1))
    assert_equal(1, File.lchown(-1, @gid, @link1))
    assert_equal(1, File.lchown(@uid, @gid, @link1))
    assert_equal(2, File.lchown(@uid, @gid, @link1, @link2))
  end

  test "lchown changes the link but not the file it links to" do
    omit_unless(@@lchown_support, @@lchown_message)
    omit_unless(ROOT, "lchown tests skipped unless run as root")

    assert_true(File.stat(@file1).uid == File.lstat(@link1).uid)
    assert_nothing_raised{ File.lchown(@uid, -1, @link1) }
    assert_false(File.stat(@file1).uid == File.lstat(@link1).uid)
    assert_equal(@uid, File.lstat(@link1).uid)
  end

  test "lchown requires at least two arguments" do
    omit_unless(@@lchown_support, @@lchown_message)
    assert_raises(ArgumentError){ File.lchown }
    assert_raises(ArgumentError){ File.lchown(-1) }
  end

  test "first and second arguments to lchown must be numeric" do
    omit_unless(@@lchown_support, @@lchown_message)
    assert_raises(TypeError){ File.lchown('bogus', -1, @file1) }
    assert_raises(TypeError){ File.lchown(-1, 'bogus', @file1) }
  end

  test "all arguments after the second must be strings" do
    omit_unless(@@lchown_support, @@lchown_message)
    assert_raises(TypeError){ File.chown(-1, -1, true) }
    assert_raises(TypeError){ File.chown(-1, -1, 777) }
  end

  def teardown
    if @@lchown_support
      File.delete(@link1) if File.exist?(@link1)
      File.delete(@link2) if File.exist?(@link2)
      File.delete(@file1) if File.exist?(@file1)
      File.delete(@file2) if File.exist?(@file2)
      @file = nil
      @uid  = nil
      @gid  = nil
    end
  end

  def self.shutdown
    @@lchown_support = nil
    @@lchown_message = nil
  end
end
