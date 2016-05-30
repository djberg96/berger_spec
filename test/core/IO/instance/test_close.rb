######################################################################
# test_close.rb
#
# Test case for the IO#close instance method.
#
# Because there are a limited number of IO file descriptors, I resort
# to using a file descriptor returned by File.new instead. This is
# acceptable to me since File#close is just using the IO#close method
# that it inherited.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_IO_Close_InstanceMethod < Test::Unit::TestCase
  include Test::Helper
   
  def setup
    @file = 'test_io_close.txt'
    @stream = File.new(@file, 'wb')
    @val = nil
  end

  test "close basic functionality" do
    assert_respond_to(@stream, :close)
    assert_nothing_raised{ @val = @stream.close }
    assert_nil(@val)
  end

  test "calling close on an already closed IO object has no effect" do
    assert_nothing_raised{ 10.times{ @stream.close } }
  end

  test "close does not accept any arguments" do
    assert_raise(ArgumentError){ @stream.close(2) }
  end

  def teardown
    @stream.close if @stream && !@stream.closed?
    remove_file(@file)
    @stream = nil
    @val = nil
  end
end
