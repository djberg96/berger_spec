########################################################################
# test_constants.rb
#
# Test suite for the Module#constants instance method.
########################################################################
require 'test/helper'
require 'test/unit'

module MConA
  M_CON_A = 1
end

module MConB
  include MConA
  M_CON_B = 1
end

module MConC
end

class CConA
  include MConA
  include MConB
end

class TC_Module_Constants_InstanceMethods < Test::Unit::TestCase
  test "constants method basic functionality" do
    assert_respond_to(MConA, :constants)
    assert_nothing_raised{ MConA.constants }
    assert_kind_of(Array, MConA.constants)
  end

  test "constants method returns expected result" do
    assert_equal([:M_CON_A], MConA.constants)
    assert_equal([:M_CON_A, :M_CON_B], MConB.constants.sort)
    assert_equal([:M_CON_A, :M_CON_B], CConA.constants.sort)
    assert_equal([], MConC.constants)
  end

  test "constants method with false argument returns expected result" do
    assert_equal([:M_CON_B], MConB.constants(false))
    assert_equal([], CConA.constants(false))
  end

  test "constants method takes a maximum of one argument" do
    assert_raise(ArgumentError){ MConA.constants(true, false) }
  end
end
