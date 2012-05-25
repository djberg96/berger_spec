###############################################################################
# test_hierarchy.rb
#
# This test case validates the existence of all the exceptions provided with
# core Ruby, as well as the appropriate subclass hierarchy.
###############################################################################
require 'test/helper'
require 'test/unit'

class TC_Exception_Hierarchy < Test::Unit::TestCase
  test "Exception class basic check" do
    assert_not_nil(Exception)
    assert_nothing_raised{ Exception.new }
  end

  test "NoMemoryError basic check" do
    assert_not_nil(NoMemoryError)
    assert_nothing_raised{ NoMemoryError.new }
  end

  test "Instances of NoMemoryError are a subclass of Exception" do
    assert_kind_of(Exception, NoMemoryError.new)
  end

  test "ScriptError class basic check" do
    assert_not_nil(ScriptError)
    assert_nothing_raised{ ScriptError.new }
  end

  test "Instances of ScriptError are a subclass of Exception" do
    assert_kind_of(Exception, ScriptError.new)
  end

  test "LoadError class basic check" do
    assert_not_nil(LoadError)
    assert_nothing_raised{ LoadError.new }
  end

  test "Instances of LoadError are a subclass of Exception" do
    assert_kind_of(Exception, LoadError.new)
  end

  test "NotImplementedError basic check" do
    assert_not_nil(NotImplementedError)
    assert_nothing_raised{ NotImplementedError.new }
  end

  test "Instances of NotImplementedError are a subclass of Exception" do
    assert_kind_of(Exception, NotImplementedError.new)
  end

  test "SyntaxError basic check" do
    assert_not_nil(SyntaxError)
    assert_nothing_raised{ SyntaxError.new }
  end

  test "Instances of SyntaxError are a subclass of Exception" do
    assert_kind_of(Exception, SyntaxError.new)
  end

  test "Instances of LoadError are a subclass of ScriptError" do
    assert_kind_of(ScriptError, LoadError.new)
  end

  test "Instances of NotImplementedError are a subclass of ScriptError" do
    assert_kind_of(ScriptError, NotImplementedError.new)
  end

  test "Instances of SyntaxError are a subclass of ScriptError" do
    assert_kind_of(ScriptError, SyntaxError.new)
  end

  test "SignalException basic check" do
    assert_not_nil(SignalException)
    assert_nothing_raised{ SignalException.new(0) }
  end

  test "SignalException accepts a supported signal name" do
    assert_nothing_raised{ SignalException.new('INT') }
  end

  test "SignalException accepts a number and an optional name" do
    assert_nothing_raised{ SignalException.new(0, 'test') }
  end

  test "SignalException constructor requires at least one argument" do
    assert_raise(ArgumentError){ SignalException.new }
  end

  test "SignalException raises an error if an unsupported signal name is used" do
    assert_raise(ArgumentError){ SignalException.new('bogus') }
    assert_raise(ArgumentError){ SignalException.new('int') }
  end

  test "SignalException does not accept more than two arguments" do
    assert_raise(ArgumentError){ SignalException.new(0, 'test', 1) }
  end

  # This should blow up IMO but doesn't
  #test "SignalException.new requires an integer and string in the 2 argument form" do
  #  assert_raise(TypeError){ SignalException.new(0, 0) }
  #end

  test "InterruptException basic check" do
    assert_not_nil(Interrupt)
    assert_nothing_raised{ Interrupt.new }
  end

  test "InterruptException is a kind of SignalException" do
    assert_kind_of(SignalException, Interrupt.new(0))
  end

  # Ok, we got a bit lazier here it seems
  test "StandardError class and subclasses are defined" do
    assert_not_nil(StandardError)
    assert_not_nil(ArgumentError)
    assert_not_nil(IOError)
    assert_not_nil(EOFError)
    assert_not_nil(IndexError)
    assert_not_nil(LocalJumpError)
    assert_not_nil(NameError)
    assert_not_nil(NoMethodError)
    assert_not_nil(RangeError)
    assert_not_nil(FloatDomainError)
    assert_not_nil(RegexpError)
    assert_not_nil(RuntimeError)
    assert_not_nil(SecurityError)
    assert_not_nil(SystemCallError)
    assert_not_nil(ThreadError)
    assert_not_nil(TypeError)
    assert_not_nil(ZeroDivisionError)
  end

  test "StandardError hierarchy instances" do
    assert_kind_of(StandardError, StandardError.new)
    assert_kind_of(StandardError, IOError.new)
    assert_kind_of(StandardError, IndexError.new)
    assert_kind_of(StandardError, LocalJumpError.new)
    assert_kind_of(StandardError, NameError.new)
    assert_kind_of(StandardError, RangeError.new)
    assert_kind_of(StandardError, RegexpError.new)
    assert_kind_of(StandardError, RuntimeError.new)
    assert_kind_of(StandardError, SystemCallError.new(0))
    assert_kind_of(StandardError, ThreadError.new)
    assert_kind_of(StandardError, TypeError.new)
    assert_kind_of(StandardError, ZeroDivisionError.new)
  end

  test "SecurityError is a kind of Exception" do
    assert_kind_of(Exception, SecurityError.new)
  end

  test "EOFError is a kind of IOError" do
    assert_kind_of(IOError, EOFError.new)
  end

  test "NoMethodError is a kind of NameError" do
    assert_kind_of(NameError, NoMethodError.new)
  end

  test "FloatDomainError is a kind of RangeError" do
    assert_kind_of(RangeError, FloatDomainError.new)
  end

  test "SystemExit basic check" do
    assert_not_nil(SystemExit)
    assert_nothing_raised{ SystemExit.new }
  end

  test "SystemExit is a kind of Exception" do
    assert_kind_of(Exception, SystemExit.new)
  end

  test "SystemStackError basic check" do
    assert_not_nil(SystemStackError)
    assert_nothing_raised{ SystemStackError.new }
  end

  test "SystemStackError is a kind of Exception" do
    assert_kind_of(Exception, SystemStackError.new)
  end
end
