#####################################################################
# test_is_file.rb
#
# Test case for the File.file? class method.
#####################################################################
require 'test/helper'
require 'test-unit'

class TC_File_File_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    if WINDOWS
      @null = "NUL"
      @dir  = "C:\\"
    else
      @null = "/dev/null"
      @dir  = "/bin"
    end

    @file = "test.txt"
    touch(@file)
  end

  test "file? basic functionality" do
    assert_respond_to(File, :file?)
    assert_nothing_raised{ File.file?(@file) }
    assert_boolean(File.file?(@file))
  end

  test "file? returns expected results" do
    assert_true(File.file?(@file))
    assert_false(File.file?(@dir))
  end

  test "file? returns false for null devices on unixy platforms" do
    omit_if(WINDOWS)
    assert_false(File.file?(@null))
  end

  test "file? returns true for null devices on windows" do
    omit_unless(WINDOWS)
    assert_true(File.file?(@null))
  end

  test "file? requires a single string argument" do
    assert_raises(ArgumentError){ File.file? }
    assert_raises(ArgumentError){ File.file?(@null, @file) }
    assert_raises(TypeError){ File.file?(nil) }
  end

  def teardown
    remove_file(@file)
    @null = nil
    @file = nil
  end
end
