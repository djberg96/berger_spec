########################################################################
# test_instance_methods.rb
#
# Test case for the Module#instance_methods instance method.
########################################################################
require 'test/helper'
require 'test/unit'

module InstMethA
  def method_a
  end
end

class InstMethB
  include InstMethA
end

class InstMethC < InstMethB
end

class TC_Module_InstanceMethods_InstanceMethod < Test::Unit::TestCase
  test "instance_methods basic functionality" do
    assert_respond_to(InstMethA, :instance_methods)
    assert_nothing_raised{ InstMethA.instance_methods }
    assert_kind_of(Array, InstMethA.instance_methods)
  end

  test "instance_methods returns the expected results" do
    assert_equal([:method_a], InstMethA.instance_methods)
    assert_true(InstMethB.instance_methods.include?(:method_a))
    assert_true(InstMethC.instance_methods.include?(:method_a))
  end

  test "instance_methods with false super argument returns expected result" do
    assert_equal([:method_a], InstMethA.instance_methods(false))
    assert_equal([], InstMethB.instance_methods(false))
    assert_equal([], InstMethC.instance_methods(false))
  end

  test "instance_methods accepts a maximum of one argument" do
    assert_raise(ArgumentError){ InstMethA.instance_methods(true, false) }
  end
end
