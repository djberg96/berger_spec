########################################################################
# test_lineno_get.rb
#
# Test case for the IO#lineno instance method.
########################################################################
require 'test/helper'
require 'test-unit'

class TC_IO_LinenoGet_InstanceMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @file   = 'test_gets.txt'
    @handle = File.new(@file, 'wb+')
    @handle.print "hello\nworld\n\nalpha\nbeta\n\ngamma\ndelta"
    @handle.rewind
  end

  test "lineno basic functionality" do
    assert_respond_to(@handle, :lineno)
    assert_nothing_raised{ @handle.lineno }
    assert_kind_of(Numeric, @handle.lineno)
  end

  test "lineno returns expected result after single gets" do
    assert_equal(0, @handle.lineno)
    assert_nothing_raised{ @handle.gets }
    assert_equal(1, @handle.lineno)
  end

  test "lineno returns expected result after multiple gets" do
    assert_equal(0, @handle.lineno)
    assert_nothing_raised{ 3.times{ @handle.gets } }
    assert_equal(3, @handle.lineno)
  end

  test "lineo returns expected result after attempt to read past end" do
    assert_equal(0, @handle.lineno)
    assert_nothing_raised{ 20.times{ @handle.gets } }
    assert_equal(8, @handle.lineno)
  end

  test "lineno returns expected result with nil separator" do
    assert_equal(0, @handle.lineno)
    assert_nothing_raised{ @handle.gets(nil) }
    assert_equal(1, @handle.lineno)
  end

  test "lineno returns expected result with empty separator" do
    assert_equal(0, @handle.lineno)
    assert_nothing_raised{ 20.times{ @handle.gets('') } }
    assert_equal(3, @handle.lineno)
  end

  test "lineno does not accept any arguments" do
    assert_raise(ArgumentError){ @handle.lineno(0) }
  end

  def teardown
    @handle.close unless @handle.closed?
    File.delete(@file) if File.exist?(@file)
    @file   = nil
    @handle = nil
  end
end
