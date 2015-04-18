###############################################################################
# test_gets.rb
#
# Test case for the IO#gets instance method.
###############################################################################
require 'test/helper'
require 'test/unit'

class TC_IO_Gets_InstanceMethod < Test::Unit::TestCase
  def setup
    @file   = 'test_gets.txt'
    @handle = File.new(@file, 'wb+')
    @handle.print "hello\nworld\n\nalpha\nbeta\n\ngamma\ndelta"
    @handle.rewind
  end

  test "gets basic functionality" do
    assert_respond_to(@handle, :gets)
    assert_nothing_raised{ @handle.gets }
    assert_kind_of(String, @handle.gets)
  end

  test "gets with no argument returns expected results" do
    assert_equal("hello\n", @handle.gets)
    assert_equal("world\n", @handle.gets)
  end

  test "gets with empty separator argument returns expected results" do
    assert_equal("hello\nworld\n\n", @handle.gets(''))
    assert_equal("alpha\nbeta\n\n", @handle.gets(''))
    assert_equal("gamma\ndelta", @handle.gets(''))
    assert_nil(@handle.gets)
  end

  test "gets with nil separator argument returns expected results" do
    assert_equal("hello\nworld\n\nalpha\nbeta\n\ngamma\ndelta", @handle.gets(nil))
    assert_nil(@handle.gets)
  end

  test "gets with string separator argument returns expected results" do
    assert_equal("hello\nworld\n\nalpha", @handle.gets('alpha'))
    assert_equal("\nbeta\n\ngamma\ndelta", @handle.gets('alpha'))
    assert_nil(@handle.gets)
  end

  test "gets with numeric limit argument returns expected results" do
    assert_equal("hello", @handle.gets(5))
    assert_equal("\n", @handle.gets(6))
    assert_equal("world", @handle.gets(5))
  end

  test "gets with separator and numeric limit arguments returns expected results" do
    assert_equal("hello\nworl", @handle.gets(nil, 10))
  end

  test "gets sets global $_ variable" do
    assert_nothing_raised{ @handle.gets }
    assert_equal("hello\n", $_)
  end

  test "in two argument form, 1st argument must be string, 2nd argument must be numeric" do
    assert_raise(TypeError){ @handle.gets(10, 'alpha') }
    assert_raise(TypeError){ @handle.gets('alpha', 'alpha') }
  end

  test "gets accepts a maximum of two arguments" do
    assert_raise(ArgumentError){ @handle.gets('', 1, 1) }
  end

  def teardown
    @handle.close unless @handle.closed?
    File.delete(@file) if File.exist?(@file)
    @file   = nil
    @handle = nil
  end
end
