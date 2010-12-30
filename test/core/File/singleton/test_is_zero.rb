#####################################################################
# test_is_zero.rb
#
# Test case for the File.zero? class method.
#####################################################################
require 'test/helper'
require 'test/unit'

class TC_File_Zero_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @zero_file    = 'temp1.txt'
    @nonzero_file = 'temp2.txt'
    @null_device  = null_device()

    touch(@zero_file)
    touch(@nonzero_file, "hello")
  end

  test "is_zero basic functionality" do
    assert_respond_to(File, :zero?)
    assert_nothing_raised{ File.zero?(@zero_file) }
  end

  test "is_zero returns the expected results" do
    assert_true(File.zero?(@zero_file))
    assert_false(File.zero?(@nonzero_file))
  end

  test "is_zero returns true for the null device" do
    assert_true(File.zero?(@null_device))
  end

  test "is_zero requires one argument" do
    assert_raises(ArgumentError){ File.zero? }
  end

  test "is_zero accept a maximum of one argument" do
    assert_raises(ArgumentError){ File.zero?(@zero_file, @nonzero_file) }
  end

  test "is_zero requires a string argument" do
    assert_raises(TypeError){ File.zero?(nil) }
    assert_raises(TypeError){ File.zero?(true) }
    assert_raises(TypeError){ File.zero?(false) }
  end

  def teardown
    remove_file(@zero_file)
    remove_file(@nonzero_file)

    @zero_file    = nil
    @nonzero_file = nil
  end
end
