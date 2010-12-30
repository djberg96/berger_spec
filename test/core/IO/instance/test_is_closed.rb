##############################################################################
# test_is_closed.rb
#
# Test case for the IO#closed? instance method.
#
# Because there are a limited number of IO file descriptors, I resort to
# using a file descriptor returned by File.new instead. This is acceptable
# to me since File#closed is just using the IO#closed method that it
# inherited.
##############################################################################
require 'test/helper'
require 'test/unit'
require 'socket'

class TC_IO_Closed_InstanceMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @file   = 'test_is_closed.txt'
    @handle = File.new(@file, 'w+')
    @host   = Socket.gethostname

    begin
      @socket = TCPServer.new(@host, 9999)
    rescue SocketError
      @host += '.local' # OSX, maybe others?
      @socket = TCPServer.new(@host, 9999)
    end
  end

  test "is_closed basic functionality" do
    assert_respond_to(@handle, :closed?)
    assert_nothing_raised{ @handle.closed? }
    assert_boolean(@handle.closed?)
  end

  test "is_closed returns the expected result for a unduplexed handle" do
    assert_false(@handle.closed?)
    assert_nothing_raised{ @handle.close }
    assert_true(@handle.closed?)
  end

  # A duplexed I/O stream isn't closed until both ends are closed.
  #
  test "is_closed returns the expected result for a duplexed IO stream" do
    assert_false(@socket.closed?)
    assert_nothing_raised{ @socket.close_read }

    assert_false(@socket.closed?)
    assert_nothing_raised{ @socket.close_write }

    assert_true(@socket.closed?)
  end

  test "is_closed does not accept any arguments" do
    assert_raise(ArgumentError){ @handle.closed?(2) }
  end

  def teardown
    @handle.close if @handle rescue nil
    @socket.close if @socket rescue nil

    remove_file(@file)

    @handle = nil
    @socket = nil
    @file   = nil
    @host   = nil
  end
end
