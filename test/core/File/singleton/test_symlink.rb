########################################################################
# test_symlink.rb
#
# Test case for the File.symlink singleton method. Note that MRI does
# not support symlinks on MS Windows.
########################################################################
require 'test/helper'
require 'test-unit'

class TC_File_Symlink_ClassMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @file = 'tc_symlink.txt'
    @link = 'link_to_tc_symlink.txt'
    touch(@file)
  end

  test "symlink basic functionality" do
    omit_if(WINDOWS)
    assert_respond_to(File, :symlink)
  end

  test "symlink creates a new linked file and leaves original intact" do
    omit_if(WINDOWS)
    assert_nothing_raised{ File.symlink(@file, @link) }
    assert_true(File.exist?(@link))
    assert_true(File.symlink?(@link))
  end

  test "symlinked file refers to same file" do
    omit_if(WINDOWS)
    File.symlink(@file, @link)
    assert_equal(File.stat(@file).ino, File.stat(@link).ino)
  end

  test "symlink raises an error if the link already exists" do
    omit_if(WINDOWS)
    File.symlink(@file, @link)
    assert_raise(Errno::EEXIST){ File.symlink(@link, @link) }
  end

  test "symlink requires two arguments" do
    omit_if(WINDOWS)
    assert_raise(ArgumentError){ File.symlink }
    assert_raise(ArgumentError){ File.symlink(@file) }
    assert_raise(ArgumentError){ File.symlink(@file, @link, @link) }
  end

  test "arguments to symlink must be strings" do
    omit_if(WINDOWS)
    assert_raise(TypeError){ File.symlink(@file, 1) }
    assert_raise(TypeError){ File.symlink(1, @file) }
  end

  def teardown
    File.delete(@link) if File.exist?(@link)
    File.delete(@file) if File.exist?(@file)
    @file = nil
    @link = nil
  end
end
