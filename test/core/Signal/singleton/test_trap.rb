###############################################################################
# test_trap.rb
#
# Test case for the Signal.trap singleton method.
###############################################################################
require 'test/helper'
require 'test/unit'

class TC_Signal_Trap_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @file   = 'test_signal_trap.txt'
    @handle = File.new(@file, 'w+')
    @sig1   = WINDOWS ? 'ABRT' : 'USR1'
    @sig2   = WINDOWS ? 'ILL'  : 'USR2'
    @signum = Signal.list[@sig1]
    @proc   = proc{ @handle.print 'world' }
     
    # These are the traps. We look to @handle or @proc to see if they fired
    # properly within the tests themselves.
    Signal.trap(@sig1){ @handle.print('hello') }
    Signal.trap(@sig2, @proc)
  end

  test "trap basic functionality" do
    assert_respond_to(Signal, :trap)
  end

  test "trap with sig string works as expected" do
    assert_nothing_raised{ Process.kill(@sig1, Process.pid) }
    @handle.rewind
    assert_equal('hello', @handle.read)
  end
   
  def test_trap_with_full_sig_name
    assert_nothing_raised{ Process.kill('SIG' + @sig1, Process.pid) }
    @handle.rewind
    assert_equal('hello', @handle.read)
  end
   
  def test_trap_with_number
    assert_nothing_raised{ Process.kill(@signum, Process.pid) }
    @handle.rewind
    assert_equal('hello', @handle.read)
  end

  def test_trap_with_proc
    assert_nothing_raised{ Process.kill(@sig2, Process.pid) }
    @handle.rewind
    assert_equal('world', @handle.read)
  end
   
  def test_trap_with_sig_symbol
    assert_nothing_raised{ Process.kill(@sig1.to_sym, Process.pid) }
    @handle.rewind
    assert_equal('hello', @handle.read)
  end
   
  def test_trap_expected_errors
    assert_raise(ArgumentError){ Signal.trap(@signum, 'USR1', 'USR2') }
    assert_raise(ArgumentError){ Signal.trap(999999){} }
  end

  def teardown
    @handle.close unless @handle.closed?
    remove_file(@file)
    @file   = nil
    @handle = nil
    @signum = nil
    @sig1   = nil
    @sig2   = nil
  end
end
