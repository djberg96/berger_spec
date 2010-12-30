######################################################################
# test_foreach.rb
#
# Test case for the IO.foreach class method.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_IO_Foreach_ClassMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @filename = 'test_foreach.txt'

    File.open(@filename, 'w'){ |fh|
      fh.puts "hello"
      fh.puts "world"
    }

    @array  = []
  end

  test "foreach basic functionality" do
    assert_respond_to(IO, :foreach)
    assert_nothing_raised{ IO.foreach(@filename){} }
  end

  test "foreach returns nil" do
    assert_nil(IO.foreach(@filename){ |line| @array << line })
  end

  test "foreach without a separator argument works as expected" do
    assert_nothing_raised{ IO.foreach(@filename){ |line| @array << line } }
    assert_equal("hello\n", @array[0])
    assert_equal("world\n", @array[1])
    assert_nil(@array[2])
  end

  test "foreach accepts an optional separator argument" do
    assert_nothing_raised{ IO.foreach(@filename, "test"){ |line| @array << line } }
  end

  test "foreach with separator argument returns the expected results" do
    assert_nothing_raised{ IO.foreach(@filename, "l"){ |line| @array << line } }
    assert_equal("hel", @array[0])
    assert_equal("l", @array[1])
    assert_equal("o\nworl", @array[2])
    assert_equal("d\n", @array[3])
    assert_nil(@array[4])
  end

  test "foreach treats an empty string for the separator argument as a paragraph separator" do
    assert_nothing_raised{ IO.foreach(@filename, ""){ |line| @array << line } }
    assert_equal("hello\nworld\n", @array[0])
    assert_nil(@array[1])
  end

  test "foreach yields tainted strings" do
    IO.foreach(@filename){ |line| @array << line }
    assert_true(@array[0].tainted?)
  end

  test "foreach without a block" do
    if PRE187
      assert_raise(LocalJumpError){ IO.foreach(@filename) }
    else
      assert_kind_of(Enumerable::Enumerator, IO.foreach(@filename))
    end
  end

  test "foreach requires at least one argument" do
    assert_raise(ArgumentError){ IO.foreach }
  end

  test "foreach accepts a maximum of two arguments" do
    assert_raise(ArgumentError){ IO.foreach(@filename, '', 1) }
  end

  test "the arguments to foreach must be strings" do
    assert_raise(TypeError){ IO.foreach(9999){} }
    assert_raise(TypeError){ IO.foreach(@filename, 1){} }
  end

  def teardown
    remove_file(@filename)

    @array    = nil
    @handle   = nil
    @filename = nil
  end
end
