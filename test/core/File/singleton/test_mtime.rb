#####################################################################
# test_mtime.rb
#
# Test case for the File.mtime class method.
#####################################################################
require 'test/helper'
require 'test-unit'

class TC_File_Mtime_SingletonMethod < Test::Unit::TestCase
  def setup
    @file = 'mtime_test.txt'
    @handle = File.open(@file, 'w')
  end

  test "mtime basic functionality" do
    assert_respond_to(File, :mtime)
    assert_nothing_raised{ File.mtime(@file) }
    assert_kind_of(Time, File.mtime(@file))
  end

  test "mtime works as expected" do
    @handle.write('test')
    assert_in_delta(1, Time.now, File.mtime(@file))
  end

  test "mtime raises an error if the file does not exist" do
    assert_raises(Errno::ENOENT){ File.mtime('bogus') }
  end

  test "mtime requires one argument only" do
    assert_raises(ArgumentError){ File.mtime }
    assert_raises(ArgumentError){ File.mtime(@file, @file) }
  end

  test "mtime requires a string argument" do
    assert_raises(TypeError){ File.mtime(1) }
  end

  def teardown
    @handle.close if @handle
    File.delete(@file) if File.exist?(@file)
    @file = nil
    @handle = nil
  end
end
