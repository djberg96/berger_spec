######################################################################
# test_pipe.rb
#
# Test case for the IO.pipe class method.
######################################################################
require 'test/helper'
require 'test-unit'

class TC_IO_Pipe_SingletonMethod < Test::Unit::TestCase
  def setup
    @read  = nil
    @write = nil
  end

  test "pipe basic functionality" do
    assert_respond_to(IO, :pipe)
    assert_kind_of(Array, IO.pipe)
  end

  test "pipe returns two IO objects" do
    assert_nothing_raised{ @read, @write = IO.pipe }
    assert_kind_of(IO, @read)
    assert_kind_of(IO, @write)
  end

  test "objects returned by pipe behave as expected" do
    assert_nothing_raised{ @read, @write = IO.pipe }
    assert_nothing_raised{ @write.print "hello" }
    assert_nothing_raised{ @write.close }
    assert_equal("hello", @read.read)
    assert_nothing_raised{ @read.close }
  end

  test "pipe method accepts a block" do
    assert_nothing_raised{ IO.pipe{ } }
    rv = IO.pipe{ |r,w|
      assert_kind_of(IO, r)
      assert_kind_of(IO, w)
    }
    assert_nil(rv)
  end

  test "pipe method takes an optional encoding argument" do
    current = Encoding.default_external
    assert_nothing_raised{ IO.pipe('ASCII') }
    assert_nothing_raised{ IO.pipe("#{current}:UTF-16LE") }
    assert_nothing_raised{ IO.pipe('ASCII'){ } }
  end

  #test "an error is raised if an invalid encoding is passed" do
  #  assert_raise(ArgumentError){ IO.pipe('bogus') }
  #end

  def teardown
    @read.close if @read && !@read.closed?
    @write.close if @write && !@write.closed?
  end
end
