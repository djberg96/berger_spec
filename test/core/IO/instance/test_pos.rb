###############################################################################
# test_pos.rb
#
# Test case for the IO#pos instance method, as well as the IO#tell alias.
###############################################################################
require 'test/helper'
require 'test-unit'

class TC_IO_Pos_InstanceMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @file   = 'test_pos.rb'
    @handle = File.new(@file, 'wb+')
    @handle.print("hello\n")
    @handle.rewind
  end

  test "pos basic functionality" do
    assert_respond_to(@handle, :pos)
    assert_nothing_raised{ @handle.pos }
    assert_kind_of(Numeric, @handle.pos)
  end

  test "tell is an alias for pos" do
    assert_alias_method(@handle, :pos, :tell)
  end

  test "pos returns the expected results" do
    assert_equal(0, @handle.pos)
    assert_nothing_raised{ @handle.getc }
    assert_equal(1, @handle.pos)
    assert_nothing_raised{ @handle.gets }
    assert_equal(6, @handle.pos)
    assert_nothing_raised{ @handle.gets } # Try again...
    assert_equal(6, @handle.pos)          # And make sure it didn't move
  end

  test "pos returns expected result after rewind" do
    assert_nothing_raised{ @handle.getc }
    assert_equal(1, @handle.pos)
    assert_nothing_raised{ @handle.rewind }
    assert_equal(0, @handle.pos)
  end

  test "pos does not accept any arguments" do
    assert_raise(ArgumentError){ @handle.pos(3) }
  end

  def teardown
    @handle.close if @handle && !@handle.closed?
    File.delete(@file) if File.exist?(@file)
    @handle = nil
    @file   = nil
  end
end
