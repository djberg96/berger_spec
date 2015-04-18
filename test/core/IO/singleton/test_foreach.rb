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

  test "foreach with length argument returns the expected results" do
    assert_nothing_raised{ IO.foreach(@filename, 3){ |line| @array << line } }
    assert_equal("hel", @array[0])
    assert_equal("lo\n", @array[1])
    assert_equal("wor", @array[2])
    assert_equal("ld\n", @array[3])
  end

  test "foreach accepts open args" do
    assert_nothing_raised{ IO.foreach(@filename, nil, mode: 'rb'){} }
    assert_nothing_raised{ IO.foreach(@filename, nil, mode: 'rb', encoding: Encoding::UTF_16LE){} }
  end

  test "foreach yields tainted strings" do
    IO.foreach(@filename){ |line| @array << line }
    assert_true(@array[0].tainted?)
  end

  test "foreach without a block" do
    assert_kind_of(Enumerator, IO.foreach(@filename))
  end

  test "foreach requires at least one argument" do
    assert_raise(ArgumentError){ IO.foreach }
  end

  test "the first argument to foreach must be a string" do
    assert_raise(TypeError){ IO.foreach(9999){} }
  end

  test "the second argument to foreach must be a string or number" do
    assert_raise(TypeError){ IO.foreach(@filename, false){} }
  end

  test "the third argument to foreach must be a hash" do
    assert_raise(TypeError){ IO.foreach(@filename, 1, 'rb'){} }
    assert_raise(TypeError){ IO.foreach(@filename, 1, true){} }
  end

  def teardown
    remove_file(@filename)

    @array    = nil
    @handle   = nil
    @filename = nil
  end
end
