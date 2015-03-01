######################################################################
# test_size.rb
#
# Test case for the File.size class method.
#
# TODO: Add big file (>2gb) tests.
#######################################################################
require 'test/helper'
require 'test-unit'

class TC_File_Size_SingletonMethod < Test::Unit::TestCase
  def self.startup
    @@zero_file  = "zero.test"  # Size 0
    @@small_file = "small.test" # Size > 0 < 2 GB
    @@large_file = "large.test" # Size > 2 GB

    File.open(@@zero_file, "wb"){}
    File.open(@@small_file, "wb"){ |fh| 50.times{ fh.syswrite('hello') } }
  end

  test "size method basic functionality" do
    assert_respond_to(File, :size)
    assert_nothing_raised{ File.size(@@zero_file) }
    assert_kind_of(Integer, File.size(@@zero_file))
  end

  test "size returns expected value" do
    assert_equal(0, File.size(@@zero_file))
    assert_equal(250, File.size(@@small_file))
  end

  test "size requires a single argument only" do
    assert_raise(ArgumentError){ File.size }
    assert_raise(ArgumentError){ File.size(@@zero_file, @@small_file) }
  end

  test "size raises an error if the file does not exist" do
    assert_raise(Errno::ENOENT){ File.size('bogus') }
  end

  test "argument to size must be a string" do
    assert_raise(TypeError){ File.size(1) }
  end

  def self.shutdown
    File.unlink(@@zero_file) if File.exist?(@@zero_file)
    File.unlink(@@small_file) if File.exist?(@@small_file)
    File.unlink(@@large_file) if File.exist?(@@large_file)
  end
end
