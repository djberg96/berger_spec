###############################################################################
# test_signal_exception.rb
#
# Because the SignalException class is defined specially in signal.c (or
# error.c) I give it some extra attention here.
###############################################################################
require 'test/helper'
require 'test/unit'

class TC_Signal_Exception_Class < Test::Unit::TestCase
  include Test::Helper

  def setup
    @sig_name  = WINDOWS ? 'ABRT' : 'USR1'
    @full_name = 'SIG' + @sig_name
    @sig_num   = Signal.list[@sig_name]
    @sig_exc   = SignalException.new(@sig_num)
  end

  test "signal exception basic functionality" do
    assert_respond_to(@sig_exc, :signo)
    assert_respond_to(@sig_exc, :signm)
  end

  test "signm returns the expected value" do
    assert_equal(@full_name, @sig_exc.signm)
    assert_equal(@full_name, SignalException.new(@full_name).signm)
    assert_equal(@full_name, SignalException.new(@sig_name).signm)
  end

  test "signo returns the expected value" do
    assert_equal(@sig_num, @sig_exc.signo)
  end

  test "constructor accepts full signal name as string or symbol" do
    assert_nothing_raised{ SignalException.new(@full_name) }
    assert_nothing_raised{ SignalException.new(@full_name.to_sym) }
  end

  test "constructor accepts abbreviated signal name as string or symbol" do
    assert_nothing_raised{ SignalException.new(@sig_name) }
    assert_nothing_raised{ SignalException.new(@sig_name.to_sym) }
  end

  test "signal constructor raises an error if numeric value is invalid" do
    assert_raise(ArgumentError){ SignalException.new(-1) }
    assert_raise(ArgumentError){ SignalException.new(99999) }
  end

  test "signal constructor accepts a maximum of two arguments" do
    assert_raise(ArgumentError){ SignalException.new(1,2,3) }
  end

  test "signal constructor raises an error if string is invalid" do
    assert_raise(ArgumentError){ SignalException.new('foo') }
  end

  test "signal constructor requires a string or numeric argument" do
    assert_raise(ArgumentError){ SignalException.new({1 => 2}) }
    assert_raise(ArgumentError){ SignalException.new([]) }
  end

  def teardown
    @sig_exc   = nil
    @sig_num   = nil
    @sig_name  = nil
    @full_name = nil
  end
end
