#####################################################################
# test_ctime.rb
#
# Test case for the File.ctime class method.
#####################################################################
require 'test/helper'
require 'test-unit'

class TC_File_Ctime_SingletonMethod < Test::Unit::TestCase
  def setup
    @file = __FILE__
  end

  test "ctime basic functionality" do
    assert_respond_to(File, :ctime)
    assert_nothing_raised{ File.ctime(@file) }
    assert_kind_of(Time, File.ctime(@file))
  end

  test "ctime raises an error if the file does not exist" do
    assert_raises(Errno::ENOENT){ File.ctime('bogus') }
  end

  test "ctime requires a single argument only" do
    assert_raises(ArgumentError){ File.ctime }
    assert_raises(ArgumentError){ File.ctime(@file, @file) }
  end

  test "argument to ctime must be a string" do
    assert_raises(TypeError){ File.ctime(1) }
  end

  def teardown
    @file = nil
  end
end
