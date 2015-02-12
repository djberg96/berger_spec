########################################################################
# test_is_symlink.rb
#
# Test case for the File.symlink? singleton method. Note that although
# Windows has supported symlinks since Windows Vista, MRI does not
# support it.
########################################################################
require 'test/helper'
require 'test-unit'

class TC_File_IsSymlink_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @file = 'test_is_symlink.txt'
    @link = 'link_to_test_is_symlink.txt'

    touch(@file)

    File.symlink(@file, @link) unless WINDOWS
  end

  test "symlink? basic functionality" do
    assert_respond_to(File, :symlink?)
  end

  test "symlink? returns expected result" do
    if WINDOWS
      assert_false(File.symlink?(@file))
      assert_false(File.symlink?(@link))
    else
      assert_false(File.symlink?(@file))
      assert_true(File.symlink?(@link))
    end
  end

  test "symlink? requires a single argument" do
    assert_raise(ArgumentError){ File.symlink? }
    assert_raise(ArgumentError){ File.symlink?(@file, @link) }
  end

  test "argument to symlink? must be a string" do
    omit_if(WINDOWS)
    assert_raise(TypeError){ File.symlink?(1) }
  end

  def teardown
    File.delete(@link) if File.exist?(@link)
    File.delete(@file) if File.exist?(@file)
  end
end
