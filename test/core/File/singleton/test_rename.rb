########################################################################
# test_rename.rb
#
# Test case for the File.rename class method.
########################################################################
require 'test/helper'
require 'test-unit'

class TC_File_Rename_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @old_name = 'tc_rename.txt'
    @new_name = 'tc_rename_new.txt'
    touch(@old_name, 'File.rename test')
  end

  test "rename basic functionality" do
    assert_respond_to(File, :rename)
    assert_nothing_raised{ File.rename(@old_name, @new_name) }
  end

  test "rename returns zero on success" do
    assert_equal(0, File.rename(@old_name, @new_name))
  end

  test "rename works as expected" do
    File.rename(@old_name, @new_name)
    assert_true(File.exist?(@new_name))
    assert_false(File.exist?(@old_name))
    assert_equal(17, File.size(@new_name))
  end

  test "rename is legal if new name is the same as the old name" do
    assert_equal(0, File.rename(@old_name, @old_name))
    assert_true(File.exist?(@old_name))
    assert_equal(17, File.size(@old_name))
  end

  test "rename requires two arguments" do
    assert_raise(ArgumentError){ File.rename(@old_name) }
  end

  test "second argument to rename cannot be an empty string" do
    assert_raise(ArgumentError, Errno::ENOENT){ File.rename(@old_name, '') }
  end

  test "rename raises an ArgumentError if the first argument does not exist" do
    assert_raise(ArgumentError, Errno::ENOENT){ File.rename('bogus.txt', @new_name) }
  end

  test "rename accepts a maximum of two arguments" do
    assert_raise(ArgumentError){ File.rename(@old_name, @new_name, 'test') }
  end

  test "arguments to rename must be strings" do
    assert_raise(TypeError){ File.rename(@old_name, 1) }
    assert_raise(TypeError){ File.rename(1, @new_name) }
  end

  def teardown
    File.delete(@old_name) if File.exist?(@old_name)
    File.delete(@new_name) if File.exist?(@new_name)
    @old_name = nil
    @new_name = nil
  end
end
