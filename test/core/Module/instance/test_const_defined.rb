########################################################################
# test_const_defined.rb
#
# Test case for the Module#const_defined? instance method.
########################################################################
require 'test/helper'
require 'test/unit'

module CD_Mod_A
  TEST  = 1
  EMPTY = ''
  BLANK = nil
end

class CD_Class_A
  include CD_Mod_A
  STUFF = 'stuff'
end

class TC_Module_ConstDefined_InstanceMethod < Test::Unit::TestCase
  test "const_defined? basic functionality" do
    assert_respond_to(CD_Mod_A, :const_defined?)
    assert_nothing_raised{ CD_Mod_A.const_defined?('TEST') }
    assert_nothing_raised{ CD_Mod_A.const_defined?('TEST', true) }
    assert_boolean(CD_Mod_A.const_defined?('TEST'))
  end

  test "const_defined? returns expected result for module directly" do
    assert_true(CD_Mod_A.const_defined?('TEST'))
    assert_true(CD_Mod_A.const_defined?('EMPTY'))
    assert_true(CD_Mod_A.const_defined?('BLANK'))
    assert_false(CD_Mod_A.const_defined?('BOGUS'))
  end

  test "const_defined? returns expected result when constant is mixed in" do
    assert_true(CD_Class_A.const_defined?('TEST'))
    assert_false(CD_Class_A.const_defined?('BOGUS'))
  end

  test "const_defined? returns expected result if inherit argument is false" do
    assert_false(CD_Class_A.const_defined?('TEST', false))
    assert_false(CD_Class_A.const_defined?('EMPTY', false))
    assert_false(CD_Class_A.const_defined?('BLANK', false))
    assert_true(CD_Class_A.const_defined?('STUFF', false))
  end

  test "const_defined? returns expected result using symbol argument" do
    assert_true(CD_Mod_A.const_defined?(:TEST))
    assert_true(CD_Class_A.const_defined?(:TEST))
    assert_false(CD_Mod_A.const_defined?(:BOGUS))
  end

  test "const_defined? requires a string or symbol argument" do
    assert_raise(TypeError){ CD_Mod_A.const_defined?([]) }
  end

  test "const_defined? raises an error if the argument is invalid" do
    assert_raise(NameError){ CD_Mod_A.const_defined?('?') }
  end
end
