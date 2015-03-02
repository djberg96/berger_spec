######################################################################
# test_new.rb
#
# Test case for the File.new class method.
######################################################################
require 'test/helper'
require 'test-unit'

class TC_File_New_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @fh    = nil
    @file  = 'test_file_new.txt'
    @flags = File::CREAT | File::TRUNC | File::WRONLY
    touch_n(@file)
  end

  test "new basic functionality" do
    assert_respond_to(File, :new)
    assert_nothing_raised{ @fh = File.new(@file) }
    assert_kind_of(File, @fh)
    assert_true(File.exist?(@file))
  end

  test "new with mode string works as expected" do
    assert_nothing_raised{ @fh = File.new(@file, 'w') }
    assert_kind_of(File, @fh)
    assert_true(File.exist?(@file))
  end

  test "new with flags works as expected" do
    assert_nothing_raised{ @fh = File.new(@file, @flags) }
    assert_kind_of(File, @fh)
    assert_true(File.exist?(@file))
  end

  test "new with flags and mode num works as expected" do
    File.delete(@file)
    assert_nothing_raised{ @fh = File.new(@file, @flags, 0644) }
    assert_kind_of(File, @fh)
    assert_equal("100644", File.stat(@file).mode.to_s(8))
    assert_true(File.exist?(@file))
  end

  test "new with num mode and flags and read only perms works as expected" do
    assert_nothing_raised{ File.delete(@file) }
    assert_nothing_raised{ @fh = File.new(@file, @flags, 0444) }
    assert_kind_of(File, @fh)
    assert_equal("100444", File.stat(@file).mode.to_s(8))
    assert_true(File.exist?(@file))
  end

  test "new with an invalid numeric mode on windows defaults to 0644" do
    omit_unless(WINDOWS)
    assert_nothing_raised{ File.delete(@file) }
    assert_nothing_raised{ @fh = File.new(@file, @flags, 0777) }
    assert_kind_of(File, @fh)
    assert_equal("100644", File.stat(@file).mode.to_s(8))
    assert_true(File.exist?(@file))
  end

  test "new with a valid numeric mode on windows works as expected" do
    omit_if(WINDOWS)
    assert_nothing_raised{ File.delete(@file) }
    assert_nothing_raised{ @fh = File.new(@file, @flags, 0755) }
    assert_kind_of(File, @fh)
    assert_equal("100755", File.stat(@file).mode.to_s(8))
    assert_true(File.exist?(@file))
  end

  test "new with a file descriptor argument works as expected" do
    assert_nothing_raised{ @fh = File.new(@file) }
    assert_nothing_raised{ @fh = File.new(@fh.fileno) }
    assert_kind_of(File, @fh)
    assert_true(File.exist?(@file))
  end

  test "new raises an error if the argument is invalid" do
    assert_raise(TypeError){ File.new(true) }
    assert_raise(TypeError){ File.new(false) }
    assert_raise(TypeError){ File.new(nil) }
  end

  test "new requires a valid fd argument if numeric" do
    assert_raise_kind_of(SystemCallError){ File.new(-1) }
  end

  test "new accepts a maximum of three arguments" do
    assert_raise(ArgumentError){ File.new(@file, File::CREAT, 0755, 'test') }
  end

  def teardown
    @fh.close if @fh
    remove_file(@file) if File.exist?(@file)
    @fh    = nil
    @file  = nil
    @flags = nil
  end
end
