#####################################################################
# test_utime.rb
#
# Test case for the File.utime class method.
#####################################################################
require 'test/helper'
require 'test-unit'

class TC_File_Utime_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @time  = Time.now
    @file1 = File.join(Dir.pwd, 'test_utime1.txt')
    @file2 = File.join(Dir.pwd, 'test_utime2.txt')

    touch(@file1)
    touch(@file2)
  end

  test "utime basic functionality" do
    assert_respond_to(File, :utime)
    assert_nothing_raised{ File.utime(0, 0, @file1) }
    assert_nothing_raised{ File.utime(0, @time, @file1) }
    assert_nothing_raised{ File.utime(@time, @time, @file1) }
    assert_kind_of(Integer, File.utime(0, 0, @file1))
  end

  test "utime returns the expected results" do
    assert_equal(1, File.utime(0, 0, @file1))
    assert_nothing_raised{ File.utime(@time, @time, @file1) }
    assert_equal(@time.to_s, File.mtime(@file1).to_s)
    assert_equal(@time.to_s, File.atime(@file1).to_s)
  end

  test "utime may be called on multiple files" do
    assert_equal(2, File.utime(0, 0, @file1, @file2))
    assert_nothing_raised{ File.utime(@time, @time, @file1, @file2) }
    assert_equal(@time.to_s, File.mtime(@file1).to_s)
    assert_equal(@time.to_s, File.atime(@file1).to_s)
    assert_equal(@time.to_s, File.mtime(@file2).to_s)
    assert_equal(@time.to_s, File.atime(@file2).to_s)
  end

  test "utime with zero for arguments and no files returns zero" do
    assert_equal(0, File.utime(0, 0))
  end

  test "utime raises an error if any file arguments are not found" do
    assert_raises(Errno::ENOENT){ File.utime(0, 0, 'bogus') }
  end

  test "utime requires at least two arguments" do
    assert_raises(ArgumentError){ File.utime }
    assert_raises(ArgumentError){ File.utime(0) }
  end

  test "first two argument to utime must be numeric" do
    assert_raises(TypeError){ File.utime('bogus', 0) }
    assert_raises(TypeError){ File.utime(0, 'bogus') }
  end

  def teardown
    remove_file(@file1)
    remove_file(@file2)

    @file1 = nil
    @file2 = nil
    @time  = nil
  end
end
