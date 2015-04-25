########################################################################
# test_ancestors.rb
#
# Test case for the Module#ancestors instance method.
########################################################################
require 'test/helper'
require 'test/unit'

module AncModA; end

class AncFoo
  module AncModB; end
  include AncModA
  include AncModB
end

class TC_Module_Ancestors_InstanceMethod < Test::Unit::TestCase
  test "ancestors basic functionality" do
    assert_respond_to(AncFoo, :ancestors)
    assert_respond_to(AncModA, :ancestors)
    assert_respond_to(AncFoo::AncModB, :ancestors)
  end

  test "ancestors returns expected results" do
    assert_equal([AncFoo, AncFoo::AncModB, AncModA], AncFoo.ancestors[0..2])
    assert_equal([AncFoo::AncModB], AncFoo::AncModB.ancestors)
    assert_equal([AncModA], AncModA.ancestors)
  end

  test "ancestors method does not accept any arguments" do
    assert_raise(ArgumentError){ AncFoo.ancestors('test') }
  end
end
