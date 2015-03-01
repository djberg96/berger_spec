#####################################################################
# test_is_writable_real.rb
#
# Test case for the File.writable_real? class method. Some tests
# skipped on MS Windows.
#####################################################################
require 'test/helper'
require 'test-unit'

class TC_File_Writable_Real_ClassMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @file1 = File.join(Dir.pwd, 'temp1.txt')
    @file2 = File.join(Dir.pwd, 'temp2.txt')
    @uid   = Etc.getpwnam('nobody').uid unless WINDOWS

    touch(@file1)
    touch(@file2)

    File.chmod(0644, @file1)
    File.chmod(0444, @file2)
  end

  test "writable_real? basic functionality" do
    assert_respond_to(File, :writable_real?)
    assert_nothing_raised{ File.writable_real?(@file1) }
  end

  test "writable_real? returns expected results as user with permissions" do
    omit_if(WINDOWS)
    omit_unless(ROOT)
    assert_nothing_raised{ Process.uid = @uid }
    assert_false(File.writable_real?(@file1))
    assert_false(File.writable_real?(@file2))
  end

  test "writable_real? returns expected results as user without permissions" do
    omit_if(WINDOWS)
    omit_if(ROOT)
    assert_true(File.writable_real?(@file1))
    assert_false(File.writable_real?(@file2))
  end

  test "writable_real? returns false if the file does not exist" do
    assert_false(File.writable_real?('bogus'))
  end

  test "writable_real? requires a single argument" do
    assert_raises(ArgumentError){ File.writable_real? }
    assert_raises(ArgumentError){ File.writable_real?(@file1, @file2) }
  end

  test "writable_real? requires a string argument" do
    assert_raises(TypeError){ File.writable_real?(1) }
    assert_raises(TypeError){ File.writable_real?(nil) }
    assert_raises(TypeError){ File.writable_real?(false) }
  end

  def teardown
    remove_file(@file1)
    remove_file(@file2)

    @file1 = nil
    @file2 = nil
    @uid   = nil unless WINDOWS
  end
end
