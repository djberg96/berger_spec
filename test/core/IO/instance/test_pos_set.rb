###############################################################################
# test_pos_set.rb
#
# Test case for the IO#pos= instance method.
###############################################################################
require 'test/helper'
require 'test/unit'

class TC_IO_PosSet_InstanceMethod < Test::Unit::TestCase
  def setup
    @file   = 'test_pos_set.rb'
    @handle = File.new(@file, 'wb+')
    @handle.print("hello\n")
    @handle.rewind
  end

  test "pos= basic functionality" do
    assert_respond_to(@handle, :pos=)
    assert_nothing_raised{ @handle.pos = 0 }
    assert_kind_of(Fixnum, @handle.pos = 0)
  end

  test "pos= returns expected result" do
    assert_equal(0, @handle.pos)
    assert_equal(4, @handle.pos = 4)
    assert_equal(4, @handle.pos)
    assert_equal(0, @handle.pos = 0)
  end

  test "pos= with value past end of file works as expected" do
    assert_equal(6, @handle.size)
    assert_nothing_raised{ @handle.pos = 99 }
    assert_equal(6, @handle.size)
  end

  test "argument to pos= must be numeric" do
    assert_raise(TypeError){ @handle.pos = 'test' }
    assert_raise(TypeError){ @handle.pos = nil }
  end

  test "pos= accepts one argument only" do
    assert_raise(ArgumentError){ @handle.send(:pos=, 1, 2) }
  end

  def teardown
    @handle.close if @handle && !@handle.closed?
    File.delete(@file) if File.exist?(@file)
    @handle = nil
    @file   = nil
  end
end
