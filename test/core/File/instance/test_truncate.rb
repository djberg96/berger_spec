######################################################################
# test_truncate.rb
#
# Test case for the File#truncate instance method.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_File_Truncate_InstanceMethod < Test::Unit::TestCase
  def setup
    @name = 'test_instance_truncate.txt'
    @file = File.open(@name, 'wb')
    @file.write('1234567890')
  end

  test "truncate basic functionality" do
    assert_respond_to(@file, :truncate)
    assert_equal(0, @file.truncate(0))
  end

  test "truncate works as expected" do
    @file.close
    assert_equal(10, File.size(@name))

    File.open(@name, 'ab'){ |fh| fh.truncate(5) }
    assert_equal(5, File.size(@name))
    assert_equal('12345', IO.read(@name))
  end

  test "setting a value larger than the current size pads the file" do
    @file.close
    assert_equal(10, File.size(@name))

    File.open(@name, 'ab'){ |fh| fh.truncate(12) }
    assert_equal(12, File.size(@name))
    assert_equal("1234567890\000\000", IO.read(@name))
  end

  test "setting the truncate value to the same size as the file is effectively a no-op" do
    @file.close
    assert_equal(10, File.size(@name))

    File.open(@name, 'ab'){ |fh| fh.truncate(10) }
    assert_equal(10, File.size(@name))
    assert_equal("1234567890", IO.read(@name))
  end

  test "setting the truncate value to zero empties a file's contents" do
    @file.close
    assert_equal(10, File.size(@name))

    File.open(@name, 'ab'){ |fh| fh.truncate(0) }
    assert_equal(0, File.size(@name))
    assert_equal("", IO.read(@name))
  end

  test "truncate requires a single argument" do
    assert_raise(ArgumentError){ @file.truncate }
    assert_raise(ArgumentError){ @file.truncate(1,2) }
  end

  test "the value sent to truncate must be non-negative" do
    assert_raise(Errno::EINVAL){ @file.truncate(-1) }
  end

  test "truncate requires a numeric argument" do
    assert_raise(TypeError){ @file.truncate(nil) }
    assert_raise(TypeError){ @file.truncate('bogus') }
  end

  def teardown
    @file.close unless @file.closed?
    File.delete(@name) if File.exist?(@name)
    @file = nil
    @name = nil
  end
end
