######################################################################
# test_close_write.rb
#
# Test case for the IO#close_write instance method.
#
# Note: This could probably use some more robust testing.
######################################################################
require 'test/helper'
require 'test/unit'
require 'socket'

class TC_IO_CloseWrite_InstanceMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @file     = 'test_close_write.txt'
    @handle   = File.new(@file, 'wb+')
    @hostname = Socket.gethostname

    begin
      @socket = TCPServer.new(@hostname, 9897)
    rescue SocketError
      @hostname += '.local'
      @socket = TCPServer.new(@hostname, 9897)
    end
  end

  test "close_write basic functionality" do
    assert_respond_to(@handle, :close_write)
    assert_respond_to(@socket, :close_write)
  end

  test "close_write returns nil on success" do
    assert_nil(@socket.close_write)
  end

  test "attempting to write to a closed IO object raises an error" do
    assert_nothing_raised{ @socket.close_write }
    assert_raises(IOError){ @socket.write('hello') }
  end

  test "close_write does not accept any arguments" do
    assert_raise(ArgumentError){ @socket.close_write(1) }
  end

  test "calling close_write on a File object raises an error" do
    assert_raise(IOError){ @handle.close_write }
  end

  def teardown
    @handle.close if @handle && !@handle.closed?
    @socket.close if @socket && !@socket.closed?

    remove_file(@file)

    @file     = nil
    @handle   = nil
    @socket   = nil
    @hostname = nil
  end
end
