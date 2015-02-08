#####################################################################
# test_directory.rb
#
# Test case for the File.directory? class method.
#####################################################################
require 'test/helper'
require 'test-unit'

class TC_File_Directory_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    if WINDOWS
      @dir  = "C:\\"
      @file = "C:\\winnt\\notepad.exe"
    else
      @dir  = "/"
      @file = "/bin/ls"
    end
  end

  test "directory? basic functionality" do
    assert_respond_to(File, :directory?)
    assert_nothing_raised{ File.directory?(@dir) }
    assert_boolean(File.directory?(@dir))
  end

  test "directory? returns expected value" do
    assert_true(File.directory?(@dir))
    assert_false(File.directory?(@file))
  end

  test "directory? requires a single argument" do
    assert_raises(ArgumentError){ File.directory? }
    assert_raises(ArgumentError){ File.directory?(@dir, @file) }
  end

  test "argument to directory? must be a string" do
    assert_raises(TypeError){ File.directory?(nil) }
    assert_raises(TypeError){ File.directory?(true) }
  end

  def teardown
    @dir = nil
    @file = nil
  end
end
