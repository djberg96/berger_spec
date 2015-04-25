######################################################################
# test_constants.rb
#
# Test case for the Module.constants module method.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_Module_Constants_SingletonMethod < Test::Unit::TestCase
  test "constants method basic functionality" do
    assert_respond_to(Module, :constants)
    assert_nothing_raised{ Module.constants }
    assert_kind_of(Array, Module.constants)
  end

  test "constants method returns expected result" do
    assert_true(Module.constants.include?(:Module))
    assert_true(Module.constants.include?(:Class))
    assert_true(Module.constants.include?(:Object))
    assert_true(Module.constants.include?(:Array))
    assert_true(Module.constants.include?(:ARGV))
    assert_true(Module.constants.include?(:ARGF))
    assert_false(Module.constants.include?(:BOGUS))
  end

  test "constants method with false inherit argument returns expected result" do
    assert_false(Module.constants(false).include?(:Module))
  end
end
