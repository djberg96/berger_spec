######################################################################
# test_constants.rb
#
# Test case for the constants associated with the Float class.
######################################################################
require 'test/helper'
require 'test/unit'

class Test_Float_Constants < Test::Unit::TestCase
  test "expected float constants are defined" do
    assert_not_nil(Float::DIG)
    assert_not_nil(Float::EPSILON)
    assert_not_nil(Float::INFINITY)
    assert_not_nil(Float::MANT_DIG)
    assert_not_nil(Float::MAX)
    assert_not_nil(Float::MAX_10_EXP)
    assert_not_nil(Float::MAX_EXP)
    assert_not_nil(Float::MIN)
    assert_not_nil(Float::MIN_10_EXP)
    assert_not_nil(Float::MIN_EXP)
    assert_not_nil(Float::NAN)
    assert_not_nil(Float::RADIX)
  end
end
