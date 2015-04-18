########################################################################
# test_lineno_set.rb
#
# Test case for the IO#lineno= instance method.
########################################################################
require 'test/helper'
require 'test-unit'

class TC_IO_LinenoSet_InstanceMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @file   = 'test_gets.txt'
    @handle = File.new(@file, 'wb+')
    @handle.print "hello\nworld\n\nalpha\nbeta\n\ngamma\ndelta"
    @handle.rewind
  end

  test "lineno= basic functionality" do
    assert_respond_to(@handle, :lineno=)
    assert_nothing_raised{ @handle.lineno = 0 }
  end

  test "lineno= with positive integer works as expected" do
    assert_equal(100, @handle.lineno = 100)
    assert_nothing_raised{ @handle.gets }
    assert_equal(101, @handle.lineno)
  end

  test "lineno= with negative integer works as expected" do
    assert_nothing_raised{ @handle.lineno = -100 }
    assert_nothing_raised{ @handle.gets }
    assert_equal(-99, @handle.lineno)
  end

  test "lineno= sets global variable" do
    assert_nothing_raised{ @handle.lineno = 100 }
    assert_nothing_raised{ @handle.gets }
    assert_equal(101, $.)
  end

  test "lineno= requires a numeric argument" do
    assert_raise(TypeError){ @handle.lineno = 'test' }
    assert_raise(TypeError){ @handle.lineno = nil }
  end

  test "lineno= takes a single argument only" do
    assert_raise(ArgumentError){ @handle.send(:lineno=) }
    assert_raise(ArgumentError){ @handle.send(:lineno=, 1, 2) }
  end

  def teardown
    @handle.close unless @handle.closed?
    File.delete(@file) if File.exist?(@file)
    @file   = nil
    @handle = nil
  end
end
