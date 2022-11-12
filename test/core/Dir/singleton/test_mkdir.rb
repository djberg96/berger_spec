######################################################################
# test_mkdir.rb
#
# Test case for the Dir.mkdir class method.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_Dir_Mkdir_Class < Test::Unit::TestCase
  include Test::Helper

  def setup
    @dir1 = File.join(base_dir(__FILE__), 'mkdir_test1')
    @dir2 = File.join(base_dir(__FILE__), 'mkdir_test2')
  end

  test "mkdir basic functionality" do
    assert_respond_to(Dir, :mkdir)
    assert_nothing_raised{ Dir.mkdir(@dir1) }
    assert_nothing_raised{ Dir.mkdir(@dir2, 0777) }
  end

  test "mkdir returns zero on success" do
    assert_equal(0, Dir.mkdir(@dir1))
  end

  test "mkdir with a single argument creates the directory as expected" do
    Dir.mkdir(@dir1)
    assert_true(File.exist?(@dir1))
    assert_true(File.directory?(@dir1))
  end

  test "mkdir without a mode defaults to mode of mask & 0777" do
    omit_if(WINDOWS || OSX, "skipping directory mode test on this platform")
    Dir.mkdir(@dir1)
    assert_equal(0, File.umask & File.stat(@dir1).mode)
  end

  test "mkdir accepts a mode as a second argument" do
    assert_nothing_raised{ Dir.mkdir(@dir2, 0777) }
    assert_true(File.exist?(@dir2))
    assert_true(File.directory?(@dir2))
  end

  # As far as I can tell, mkdir on OS X always uses the umask value.
  # On MS Windows the argument is accepted but ignored.
  #
  test "mkdir with mode sets directory to expected permissions" do
    omit_if(WINDOWS || OSX, "skipping directory mode test on this platform")
    assert_nothing_raised{ Dir.mkdir(@dir2, 0744) }
  end

  test "the first argument to mkdir must be a string" do
    assert_raise(TypeError){ Dir.mkdir(1) }
    assert_raise(TypeError){ Dir.mkdir(true) }
  end

  test "the second argument to mkdir must be a number" do
    assert_raise(TypeError){ Dir.mkdir(@dir1, true) }
  end

  test "mkdir raises an error if the directory already exists" do
    Dir.mkdir(@dir1)
    assert_raise_kind_of(SystemCallError){ Dir.mkdir(@dir1) }
  end

  def teardown
    remove_dir(@dir1) if File.exist?(@dir1)
    remove_dir(@dir2) if File.exist?(@dir2)
    @dir1 = nil
    @dir2 = nil
  end
end
