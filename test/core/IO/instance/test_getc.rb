###############################################################################
# test_getc.rb
#
# Test case for the IO#getc instance method.
###############################################################################
require 'test/helper'
require 'test/unit'

class TC_IO_Getc_InstanceMethod < Test::Unit::TestCase
  def setup
    @file   = 'test_getc.txt'
    @handle = File.new(@file, 'wb+')
    @handle.print "wo\tr\nld5"
    @handle.rewind
  end

  test "getc basic functionality" do
    assert_respond_to(@handle, :getc)
    assert_nothing_raised{ @handle.getc }
    assert_kind_of(String, @handle.getc)
  end

  # We'll call it once for each character, plus two more to verify
  # that it returns nil at eof.

  test "getc returns expected results" do
    assert_equal('w', @handle.getc)
    assert_equal('o', @handle.getc)
    assert_equal("\t", @handle.getc)
    assert_equal('r', @handle.getc)
    assert_equal("\n", @handle.getc)
    assert_equal('l', @handle.getc)
    assert_equal('d', @handle.getc)
    assert_equal('5', @handle.getc)
    assert_equal(nil, @handle.getc)
  end

  test "getc does not take any arguments" do
    assert_raise(ArgumentError){ @handle.getc(1) }
  end

  def teardown
    @handle.close if @handle && !@handle.closed?
    File.delete(@file) if File.exist?(@file)
    @file   = nil
    @handle = nil
  end
end
