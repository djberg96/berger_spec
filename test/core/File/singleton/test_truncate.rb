######################################################################
# test_truncate.rb
#
# Test case for the File.truncate class method.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_File_Truncate_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @file = 'test_truncate.txt'
    @fh  = File.open(@file, 'w')
    File.open(@file, 'wb'){ |fh| fh.write("1234567890") }
  end

  test "truncate basic functionality" do
    assert_respond_to(File, :truncate)
    assert_nothing_raised{ File.truncate(@file, 0) }
    assert_equal(0, File.truncate(@file, 0))
  end

  test "truncate behaves as expected" do
    assert_equal(10, File.size(@file))
    assert_nothing_raised{ File.truncate(@file, 5) }
    assert_equal(5, File.size(@file))
    assert_equal("12345", IO.read(@file))
  end

  test "truncate increases file size if size argument is larger than file" do
    assert_nothing_raised{ File.truncate(@file, 12) }
    assert_equal("1234567890\000\000", IO.read(@file))
  end

  test "truncate effectively does nothing if the size argument is the same as the file size" do
    assert_nothing_raised{ File.truncate(@file, File.size(@file)) }
    assert_equal("1234567890", IO.read(@file))
  end

  test "truncate with a size argument of zero works as expected" do
    assert_nothing_raised{ File.truncate(@file, 0) }
    assert_equal("", IO.read(@file))
  end

  test "truncate requires two arguments" do
    assert_raise(ArgumentError){ File.truncate(@file) }
    assert_raise(ArgumentError){ File.truncate(@file, 1, 1) }
  end

  test "size argument for truncate cannot be negative" do
    assert_raise(Errno::EINVAL){ File.truncate(@file, -1) }
  end

  test "first argument must be a string, second argument must be numeric" do
    assert_raise(TypeError){ File.truncate(nil, 1) }
    assert_raise(TypeError){ File.truncate(@file, nil) }
  end

  def teardown
    @fh.close if @fh && !@fh.closed?
    File.delete(@file) if File.exist?(@file)
    @file = nil
    @fh = nil
  end
end
