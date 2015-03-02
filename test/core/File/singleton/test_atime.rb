#####################################################################
# test_atime.rb
#
# Test case for the File.atime class method.
#####################################################################
require 'test/helper'
require 'test-unit'

class TC_File_Atime_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @file = File.join(Dir.pwd, 'test.txt')
    touch(@file)
  end

  test "atime basic functionality" do
    assert_respond_to(File, :atime)
    assert_nothing_raised{ File.atime(@file) }
    assert_kind_of(Time, File.atime(@file))
  end

  test "atime raises an error if the file does not exist" do
    assert_raises(Errno::ENOENT){ File.atime('bogus') }
  end

  test "atime requires a single argument" do
    assert_raises(ArgumentError){ File.atime }
    assert_raises(ArgumentError){ File.atime(@file, @file) }
  end

  test "argument to atime must be a string" do
    assert_raises(TypeError){ File.atime(1) }
  end

  def teardown
    remove_file(@file)
    @file = nil
  end
end
