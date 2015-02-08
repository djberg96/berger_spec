########################################################################
# test_has_size.rb
#
# Test case for the File.size? class method.
########################################################################
require 'test/helper'
require 'test-unit'

class TC_File_HasSize_ClassMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @file_zero    = 'tc_has_size_zero.txt'
    @file_nonzero = 'tc_has_size_nonzero.txt'
    touch(@file_zero)
    touch(@file_nonzero, 'Test for File.size?')
  end

  test "size? basic functionality" do
    assert_respond_to(File, :size?)
    assert_nothing_raised{ File.size?(@file_zero) }
    assert_nothing_raised{ File.size?(@file_nonzero) }
  end

  test "size? returns expected result" do
    assert_equal(nil, File.size?(@file_zero))
    assert_equal(20, File.size?(@file_nonzero))
  end

  test "size? returns nil on non-existent file" do
    assert_equal(nil, File.size?('bogus.txt'))
  end

  test "size? accepts a maximum of one argument" do
    assert_raise(ArgumentError){ File.size?(@file_zero, 1) }
  end

  test "argument to size? must be a string" do
    assert_raise(TypeError){ File.size?(1) }
  end

  def teardown
    File.delete(@file_zero) if File.exist?(@file_zero)
    File.delete(@file_nonzero) if File.exist?(@file_nonzero)

    @file_zero    = nil
    @file_nonzero = nil
  end
end
