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

    @msg  = '=> May fail on MS Windows'
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
    assert_false(File.file?(@null), @msg)
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
    @msg  = nil
  end
end
