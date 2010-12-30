######################################################################
# test_close_read.rb
#
# Test case for the IO#close_read instance method.
#
# Note: This could probably use some more robust testing.
######################################################################
require 'test/helper'
require 'test/unit'
require 'socket'

class TC_IO_CloseRead_InstanceMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @filename = 'test_close_read.txt'
    @hostname = Socket.gethostname
    @handle   = File.new(@filename, 'wb+')

    begin
      @socket = TCPServer.new(@hostname, 9897)
    rescue SocketError
      @hostname += '.local'
      @socket = TCPServer.new(@hostname, 9897)
    end
  end

  test "close_read basic functionality" do
    assert_respond_to(@handle, :close_read)
    assert_respond_to(@socket, :close_read)
  end

  test "close_read returns nil on success" do
    assert_nil(@socket.close_read)
  end

  test "calling close_read on a closed IO object causes an error" do
    assert_nothing_raised{ @socket.close_read }
    assert_raises(IOError){ @socket.read }
  end

  test "close_read does not accept any arguments" do
    assert_raise(ArgumentError){ @socket.close_read(1) }
  end

  test "File objects do not implement close_read" do
    assert_raise(IOError){ @handle.close_read }
  end

  def teardown
    @handle.close if @handle && !@handle.closed?
    @socket.close if @socket && !@socket.closed?

    remove_file(@filename)

    @filename = nil
    @handle   = nil
    @socket   = nil
    @hostname = nil
  end
end
