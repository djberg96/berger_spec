#####################################################################
# test_constants.rb
#
# Test cases for constants in the Math module.
#####################################################################
require 'test/helper'
require 'test/unit'

class TC_Math_Constants < Test::Unit::TestCase
  # Euler's constant
  test "Math::E is defined" do
    assert_not_nil(Math::E)
    assert_kind_of(Float, Math::E)
    assert_in_delta(2.71828, Math::E, 0.001)
  end

  test "Math::PI is defined" do
    assert_not_nil(Math::PI)
    assert_kind_of(Float, Math::PI)
    assert_in_delta(3.14, Math::PI, 0.01)
  end
end
