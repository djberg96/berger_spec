######################################################################
# test_fileno.rb
#
# Test case for the IO#fileno instance method and the IO#to_i alias.
######################################################################
require 'test-unit'
require 'test/helper'

class TC_IO_Fileno_InstanceMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @file   = 'fileno_test.txt'
    @handle = File.new(@file, 'w')
  end

  test "fileno basic functionality" do
    assert_respond_to(@handle, :fileno)
    assert_kind_of(Fixnum, @handle.fileno)
    assert_true(@handle.fileno > 2)
  end

  test "to_i is an alias for fileno" do
    assert_alias_method(@handle, :fileno, :to_i)
  end

  test "special handles respond to fileno method" do
    assert_respond_to(STDIN, :fileno)
    assert_respond_to(STDOUT, :fileno)
    assert_respond_to(STDERR, :fileno)
  end

  test "special handles return expected fileno values" do
    omit_if(JRUBY)
    assert(STDIN.fileno == 0)
    assert(STDOUT.fileno == 1)
    assert(STDERR.fileno == 2)
  end

  test "fileno does not take any arguments" do
    assert_raise(ArgumentError){ @handle.fileno(4) }
  end

  def teardown
    @handle.close if @handle && !@handle.closed?
    @handle = nil
    remove_file(@file)
  end
end
