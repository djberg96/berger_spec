#####################################################################
# test_blockdev.rb
#
# Test case for the File.blockdev? class method.
#
# For this test case I do my best to find a block device (floppy,
# etc) in a cross platform way, but there is no guarantee.  Thus,
# some tests will fail if a block device can't be found.
#
# Also, the definition of a block device is looser on Windows, where
# anything that isn't a character, pipe or disk file type is
# considered a block device.
#####################################################################
require 'test/helper'
require 'test-unit'

class TC_File_IsBlockdev_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    if WINDOWS
      @block_dev = "NUL"
       @other_dev = "C:\\"
    else
      if File.exist?("/dev/fd0")
        @block_dev = "/dev/fd0"
      elsif File.exist?("/dev/diskette")
        @block_dev = "/dev/diskette"
      elsif File.exist?("/dev/cdrom")
        @block_dev = "/dev/cdrom"
      elsif File.exist?("/dev/sr0") # CDROM
        @block_dev = "/dev/sr0"
      elsif File.exist?("/dev/disk0")
        @block_dev = "/dev/disk0"
      else
        @block_dev = nil
      end
      @other_dev = "/usr/bin"
    end
  end

  test "blockdev? basic functionality" do
    assert_respond_to(File, :blockdev?)
    assert_nothing_raised{ File.blockdev?(@block_dev) }
    assert_boolean(File.blockdev?(@block_dev))
  end

  test "blockdev? returns the expected results" do
    if WINDOWS
      assert_false(File.blockdev?(@block_dev))
    else
      assert_true(File.blockdev?(@block_dev))
    end
    assert_false(File.blockdev?(@other_dev))
  end

  test "blockdev? returns false if the path does not exist" do
    assert_false(File.blockdev?('bogus'))
  end

  test "blockdev? requires a single argument" do
    assert_raises(ArgumentError){ File.blockdev? }
    assert_raises(ArgumentError){ File.blockdev?(@block_dev, @other_dev) }
  end

  test "blockdev? requires a string argument" do
    assert_raises(TypeError){ File.blockdev?(nil) }
  end

  def teardown
    @block_dev = nil
  end
end
