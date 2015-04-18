###############################################################################
# test_readchar.rb
#
# Test case for the IO#readchar instance method. These tests are nearly
# identical to the IO#getc tests.
###############################################################################
require 'test/helper'
require 'test/unit'

class TC_IO_Readchar_InstanceMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @file   = 'test_readchar.txt'
    @handle = File.new(@file, 'wb+')
    @handle.print "wo\tr\nld5"
    @handle.rewind
  end

  test "readchar basic functionality" do
    assert_respond_to(@handle, :readchar)
    assert_nothing_raised{ @handle.readchar }
    assert_kind_of(String, @handle.readchar)
  end

  # We'll call it once for each character
  test "readchar returns expected result" do
    assert_equal('w', @handle.readchar)
    assert_equal('o', @handle.readchar)
    assert_equal("\t", @handle.readchar)
    assert_equal('r', @handle.readchar)
    assert_equal("\n", @handle.readchar)
    assert_equal('l', @handle.readchar)
    assert_equal('d', @handle.readchar)
    assert_equal('5', @handle.readchar)
  end

  test "readchar does not take any arguments" do
    assert_raise(ArgumentError){ @handle.readchar(1) }
  end

  test "readchar raises an error if you read past the end of file" do
    assert_raise(EOFError){ 10.times{ @handle.readchar } }
  end

  def teardown
    @handle.close if @handle && !@handle.closed?
    File.delete(@file) if File.exist?(@file)
    @file   = nil
    @handle = nil
  end
end
