######################################################################
# test_ftype.rb
#
# Test case for the File.ftype class method.
#
# TODO: Add tests for 'socket' and 'unknown', and better tests for
# MS Windows.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_File_Ftype_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @file = __FILE__
    @dir  = Dir.pwd
    @fifo = nil

    if WINDOWS
      @block_dev = "NUL"
      @fifo  = nil
      @block = nil
      @link  = nil
      @char  = nil
    else
      @char = Pathname.new('/dev/null').realpath
      @fifo = "test_fifo"

      system("mkfifo #{@fifo}")

      if File.exist?("/dev/fd0")
        @block = Pathname.new("/dev/fd0").realpath
        @link  = "/dev/fd0" if File.symlink?("/dev/fd0")
      elsif File.exist?("/dev/diskette")
        @block = Pathname.new("/dev/diskette").realpath
        @link  = "/dev/diskette" if File.symlink?("/dev/diskette")
      elsif File.exist?("/dev/cdrom")
        @block = Pathname.new("/dev/cdrom").realpath
        @link  = "/dev/cdrom" if File.symlink?("/dev/cdrom")
      elsif File.exist?("/dev/sr0") # CDROM
        @block = Pathname.new("/dev/sr0").realpath
        @link  = "/dev/sr0" if File.symlink?("/dev/sr0")
      elsif File.exist?("/dev/disk0")
        @block = "/dev/disk0"
        @link  = "/tmp"
      else
        @block = nil
        @link  = nil
      end
    end
  end

  test "ftype basic functionality" do
    assert_respond_to(File, :ftype)
    assert_nothing_raised{ File.ftype(@file) }
    assert_kind_of(String, File.ftype(@file))
  end

  test "ftype returns 'file' for a regular file" do
    assert_equal('file', File.ftype(@file))
  end

  test "ftype returns 'directory' for a directory" do
    assert_equal('directory', File.ftype(@dir))
  end

  test "ftype returns 'characterSpecial' for a character special device" do
    omit_if(WINDOWS)
    assert_equal('characterSpecial', File.ftype(@char))
  end

  test "ftype returns 'blockSpecial' for a block device" do
    omit_if(WINDOWS)
    assert_equal('blockSpecial', File.ftype(@block), "BLOCK WAS: #{@block}")
  end

  test "ftype returns 'link' for a link" do
    omit_if(WINDOWS)
    assert_equal('link', File.ftype(@link))
  end

  test "ftype returns 'fifo' for a fifo device" do
    omit_if(WINDOWS)
    assert_equal('fifo', File.ftype(@fifo))
  end

  test "ftype requires a single argument" do
    assert_raises(ArgumentError){ File.ftype }
    assert_raises(ArgumentError){ File.ftype(@file, @file) }
  end

  test "ftype raises an error if the argument is invalid" do
    assert_raises(Errno::ENOENT){ File.ftype('bogus') }
  end

  def teardown
    remove_file(@fifo)
    @file   = nil
    @dir    = nil
    @char   = nil
    @block  = nil
    @fifo   = nil
    @link   = nil
    @socket = nil
  end
end
