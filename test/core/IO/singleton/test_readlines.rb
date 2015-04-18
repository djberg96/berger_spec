######################################################################
# test_readlines.rb
#
# Test case for the IO.readlines class method.
######################################################################
require 'test/helper'
require 'test-unit'

class TC_IO_Readlines_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @file = 'test.txt'
    File.open(@file, 'w+'){ |fh|
      fh.puts "hello"
      fh.puts "world"
    }
  end

  test "readlines basic functionality" do
    assert_respond_to(IO, :readlines)
    assert_nothing_raised{ IO.readlines(@file) }
    assert_kind_of(Array, IO.readlines(@file))
  end

  # The duplicate test here is intentional. We want to verify that the
  # file pointer is definitely reset between readliness.
  #
  test "readlines returns expected value" do
    assert_equal(["hello\n", "world\n"], IO.readlines(@file))
    assert_equal(["hello\n", "world\n"], IO.readlines(@file))
  end

  test "readlines with string separator works as expected" do
    assert_equal(["hell", "o\nworld\n"], IO.readlines(@file, "ll"))
    assert_equal(["hel","l", "o\nworl", "d\n"], IO.readlines(@file, "l"))
    assert_equal(["hello", "\nworld\n"], IO.readlines(@file, "hello"))
  end

  test "readlines with nil separator works as expected" do
    assert_equal(["hello\nworld\n"], IO.readlines(@file, nil))
  end

  test "readlines with limit works as expected" do
    assert_equal(["hell", "o\n", "worl", "d\n"], IO.readlines(@file, 4))
  end

  test "readlines with negative limit is treated as nil" do
    assert_equal(["hello\n", "world\n"], IO.readlines(@file, -1))
    assert_equal(["hello\n", "world\n"], IO.readlines(@file, -5))
  end

  test "first argument to readlines must be a string" do
    assert_raise(TypeError){ IO.readlines(2) }
    assert_raise(TypeError){ IO.readlines(nil) }
  end

  test "limit value cannot be zero" do
    assert_raise(ArgumentError){ IO.readlines(@file, 0) }
  end

  def teardown
    remove_file(@file)
  end
end
