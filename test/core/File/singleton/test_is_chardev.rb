#####################################################################
# test_is_chardev.rb
#
# Test case for the File.chardev? class method.
#####################################################################
require 'test/helper'
require 'test-unit'

class TC_File_Chardev_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    if WINDOWS
      @char_dev  = 'NUL'
      @other_dev = "C:\\"
    else
      @char_dev  = "/dev/null"
      @other_dev = "/"
    end
  end

  test "chardev? basic functionality" do
    assert_respond_to(File, :chardev?)
    assert_nothing_raised{ File.chardev?(@char_dev) }
    assert_boolean(File.chardev?(@char_dev))
  end

  test "chardev? returns the expected results" do
    if WINDOWS
      assert_false(File.chardev?(@char_dev))
    else
      assert_true(File.chardev?(@char_dev))
    end
    assert_false(File.chardev?(@other_dev))
  end

  test "chardev? returns false if the file does not exist" do
    assert_false(File.chardev?('bogus'))
  end

  test "chardev? requires a single argument" do
    assert_raises(ArgumentError){ File.chardev? }
    assert_raises(ArgumentError){ File.chardev?(@char_dev, @other_dev) }
  end

  test "argument to chardev? must be a string" do
    assert_raises(TypeError){ File.chardev?(nil) }
  end

  def teardown
    @char_dev  = nil
    @other_dev = nil
  end
end
