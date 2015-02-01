######################################################################
# test_delete.rb
#
# Test case for the Dir.delete class method.  This also covers the
# Dir.rmdir and Dir.unlink aliases.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_Dir_Delete_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @cur_dir = base_dir(__FILE__)
    @new_dir = File.join(@cur_dir, 'bogus')
    Dir.mkdir(@new_dir)
  end

  test "delete basic functionality" do
    assert_respond_to(Dir, :delete)
    assert_nothing_raised{ Dir.delete(@new_dir) }
  end

  test "rmdir is an alias for delete" do
    assert_respond_to(Dir, :rmdir)
    assert_alias_method(Dir, :rmdir, :delete)
  end

  test "unlink is an alias for delete" do
    assert_respond_to(Dir, :unlink)
    assert_alias_method(Dir, :rmdir, :delete)
  end

  test "delete returns zero upon success" do
    assert_equal(0, Dir.delete(@new_dir))
  end

  test "delete requires a string argument" do
    assert_raise(TypeError){ Dir.delete(1) }
  end

  test "delete requires one argument only" do
    assert_raise(ArgumentError){ Dir.delete }
    assert_raise(ArgumentError){ Dir.delete(@new_dir, @new_dir) }
  end

  test "delete cannot delete the current process directory" do
    assert_raise_kind_of(SystemCallError){ Dir.delete(@cur_dir) }
  end

  def teardown
    remove_dir(@new_dir) if File.exist?(@new_dir)
    @cur_dir = nil
    @new_dir = nil
  end
end
