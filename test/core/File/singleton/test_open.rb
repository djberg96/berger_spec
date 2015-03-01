######################################################################
# test_open.rb
#
# Test case for the File.open class method.
######################################################################
require 'test/helper'
require 'test-unit'

class TC_File_Open_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @file = 'tc_open.txt'
    @fh = nil
    @fd = nil
    @flags = File::CREAT | File::TRUNC | File::WRONLY
    touch_n(@file)
  end

  test "open basic functionality" do
    assert_respond_to(File, :open)
    assert_nothing_raised{ @fh = File.open(@file) }
    assert_kind_of(File, @fh)
    assert_true(File.exist?(@file))
  end

  test "open with block basic functionality" do
    assert_nothing_raised{ File.open(@file){ |fh| @fd = fh.fileno } }
    assert_raise_kind_of(SystemCallError){ File.open(@fd) }
    assert_true(File.exist?(@file))
  end

  test "open with optional mode string works as expected" do
    assert_nothing_raised{ @fh = File.open(@file, 'w') }
    assert_kind_of(File, @fh)
    assert_true(File.exist?(@file))
  end

  test "open with mode string and block works as expected" do
    assert_nothing_raised{ File.open(@file, 'w'){ |fh| @fd = fh.fileno } }
    assert_raise_kind_of(SystemCallError){ File.open(@fd) }
    assert_true(File.exist?(@file))
  end

  test "open accepts numeric mode" do
    assert_nothing_raised{ @fh = File.open(@file, @flags) }
    assert_kind_of(File, @fh)
    assert_true(File.exist?(@file))
  end

  test "open with numeric mode and block works as expected" do
    assert_nothing_raised{ File.open(@file, 'w'){ |fh| @fd = fh.fileno } }
    assert_raise_kind_of(SystemCallError){ File.open(@fd) }
    assert_true(File.exist?(@file))
  end

  # For this test we delete the file first to reset the permissions.
  #
  # MS Windows only supports two file modes - 0644 (read-write) and 0444
  # (read-only). So, we'll verify that those two work, and that it defaults
  # to the expected 0644 for invalid modes.
  #
  test "open with numeric mode 0644 on windows works as expected" do
    File.delete(@file)
    assert_nothing_raised{ @fh = File.open(@file, @flags, 0644) }
    assert_kind_of(File, @fh)
    assert_equal("100644", File.stat(@file).mode.to_s(8))
    assert_equal(true, File.exist?(@file))
  end

  test "open with numeric mode 0444 on windows works as expected" do
    File.delete(@file)
    assert_nothing_raised{ @fh = File.open(@file, @flags, 0444) }
    assert_kind_of(File, @fh)
    assert_equal("100444", File.stat(@file).mode.to_s(8))
    assert_equal(true, File.exist?(@file))
  end

  test "open with invalid numeric mode on windows defaults to 0644" do
    File.delete(@file)
    assert_nothing_raised{ @fh = File.open(@file, @flags, 0777) }
    assert_kind_of(File, @fh)
    assert_equal("100644", File.stat(@file).mode.to_s(8))
    assert_equal(true, File.exist?(@file))
  end

  test "open with numeric mode and permissions works as expected" do
    omit_if(WINDOWS)
    File.delete(@file)
    assert_nothing_raised{ @fh = File.open(@file, @flags, 0755) }
    assert_equal("100755", File.stat(@file).mode.to_s(8))
    assert_kind_of(File, @fh)
    assert_true(File.exist?(@file))
  end

  test "open with numeric mode of 0644 and block works as expected" do
    File.delete(@file)
    assert_nothing_raised{ File.open(@file, @flags, 0644){ |fh| @fd = fh.fileno } }
    assert_raise_kind_of(SystemCallError){ File.open(@fd) }
    assert_equal("100644", File.stat(@file).mode.to_s(8))
    assert_true(File.exist?(@file))
  end

  test "open with numeric mode and read only permissions with block" do
    File.delete(@file)
    assert_nothing_raised{ File.open(@file, @flags, 0444){ |fh| @fd = fh.fileno } }
    assert_raise_kind_of(SystemCallError){ File.open(@fd) }
    assert_equal("100444", File.stat(@file).mode.to_s(8))
    assert_true(File.exist?(@file))
  end

  test "open with numeric mode and invalid permissions with block on windows works as expected" do
    omit_unless(WINDOWS)
    File.delete(@file)
    assert_nothing_raised{ File.open(@file, @flags, 0755){ |fh| @fd = fh.fileno } }
    assert_raise_kind_of(SystemCallError){ File.open(@fd) }
    assert_equal("100644", File.stat(@file).mode.to_s(8))
    assert_true(File.exist?(@file))
  end

  test "open with numeric mode and write permissions with block" do
    omit_if(WINDOWS)
    File.delete(@file)
    assert_nothing_raised{ File.open(@file, @flags, 0755){ |fh| @fd = fh.fileno } }
    assert_raise_kind_of(SystemCallError){ File.open(@fd) }
    assert_equal("100755", File.stat(@file).mode.to_s(8))
    assert_equal(true, File.exist?(@file))
  end

  test "open with file descriptor value works as expected" do
    assert_nothing_raised{ @fh = File.open(@file) }
    assert_nothing_raised{ @fh = File.open(@fh.fileno) }
    assert_kind_of(File, @fh)
    assert_equal(true, File.exist?(@file))
  end

  # Note that this test invalidates the file descriptor in @fh. That's
  # handled in the teardown via the 'rescue nil'.

  test "open with file descriptor and block works as expected" do
    assert_nothing_raised{ @fh = File.open(@file) }
    assert_nothing_raised{ File.open(@fh.fileno){ |fh| @fd = fh.fileno } }
    assert_raise_kind_of(SystemCallError){ File.open(@fd) }
    assert_kind_of(File, @fh)
    assert_true(File.exist?(@file))
  end

  test "open requires a string or numeric for the first argument" do
    assert_raise(TypeError){ File.open(true) }
    assert_raise(TypeError){ File.open(false) }
    assert_raise(TypeError){ File.open(nil) }
  end

  test "open raises an error if an invalid numeric is provided" do
    assert_raise_kind_of(SystemCallError){ File.open(-1) }
  end

  test "open takes a maximum of three arguments" do
    assert_raise(ArgumentError){ File.open(@file, File::CREAT, 0755, 'test') }
  end

  def teardown
    begin
      @fh.close if @fh && !@fh.closed?
    rescue Errno::EBADF
      # Do nothing. Caused by test_open_with_fd_and_block
    end

    remove_file(@file)

    @fh    = nil
    @fd    = nil
    @file  = nil
    @flags = nil
  end
end
