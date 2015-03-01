#####################################################################
# test_writable.rb
#
# Test case for the File.writable? class method. Some tests
# skipped on MS Windows.
#####################################################################
require 'test/helper'
require 'test-unit'

class TC_File_Writable_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @file1 = File.join(Dir.pwd, 'temp1.txt')
    @file2 = File.join(Dir.pwd, 'temp2.txt')

    touch(@file1)
    touch(@file2)

    File.chmod(0766, @file1)
    File.chmod(0444, @file2)
  end

  test "writable? basic functionality" do
    assert_respond_to(File, :writable?)
    assert_nothing_raised{ File.writable?(@file1) }
    assert_boolean(File.writable?(@file1))
  end

  test "writable returns the expected results" do
    omit_if(WINDOWS)
    assert_true(File.writable?(@file1))
    assert_false(File.writable?(@file2))
    assert_false(File.writable?('bogus'))
  end

  test "writable? requires a single argument" do
    assert_raises(ArgumentError){ File.writable? }
  end

  test "argument to writable? must be a string" do
    assert_raises(TypeError){ File.writable?(1) }
    assert_raises(TypeError){ File.writable?(nil) }
    assert_raises(TypeError){ File.writable?(false) }
  end

  def teardown
    remove_file(@file1)
    remove_file(@file2)

    @file1 = nil
    @file2 = nil
  end
end
