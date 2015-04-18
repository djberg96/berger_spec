###############################################################################
# test_each.rb
#
# Test case for the IO#each instance method and the IO#each_line alias.
###############################################################################
require 'test-unit'
require 'test/helper'

class TC_IO_Each_InstanceMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @file   = 'test_io_each.txt'
    @handle = File.new(@file, 'w+')
    @array  = []
    @handle << "Hello\n" << "World\n"
    @handle.rewind
  end

  test "each basic functionality" do
    assert_respond_to(@handle, :each)
    assert_nothing_raised{ @handle.each{} }
  end

  test "each_line is an alias for each" do
    assert_alias_method(@handle, :each_line, :each)
  end

  test "each with no separator works as expected" do
    assert_nothing_raised{ @handle.each{ |line| @array << line } }
    assert_equal(["Hello\n", "World\n"], @array)
  end

  test "each with string separator works as expected" do
    assert_nothing_raised{ @handle.each('l'){ |line| @array << line } }
    assert_equal(["Hel", "l", "o\nWorl", "d\n"], @array)
  end

  test "each with an empty string separator works as expected" do
    assert_nothing_raised{ @handle.each(''){ |line| @array << line } }
    assert_equal(["Hello\nWorld\n"], @array)
  end

  test "each with numeric separator works as expected" do
    assert_nothing_raised{ @handle.each(3){ |line| @array << line } }
    assert_equal("Hel", @array[0])
    assert_equal("lo\n", @array[1])
    assert_equal("Wor", @array[2])
    assert_equal("ld\n", @array[3])
  end

  test "each with string and numeric separator works as expected" do
    assert_nothing_raised{ @handle.each('lo', 5){ |line| @array << line } }
    assert_equal("Hello", @array[0])
    assert_equal("\nWorl", @array[1])
    assert_equal("d\n", @array[2])
  end

  test "each with no block returns an enumerator" do
    assert_kind_of(Enumerator, @handle.each)
  end

  test "each accepts a maximum of two arguments" do
    assert_raises(ArgumentError){ @handle.each('x', 2, 3){} }
  end

  def teardown
    @handle.close if @handle && !@handle.closed?
    remove_file(@file)
    @array  = nil
    @handle = nil
    @file   = nil
  end
end
