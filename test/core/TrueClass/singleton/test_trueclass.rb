###########################################################
# test_trueclass.rb
#
# Test case for the TrueClass itself.
###########################################################
require 'test/helper'
require 'test/unit'

class TC_TrueClass < Test::Unit::TestCase
  test "true is the expected type" do
    assert_true(true.is_a?(TrueClass))
    assert_false(true.is_a?(FalseClass))
  end

  test "true#to_s returns the expected value" do
    assert_equal('true', true.to_s)
  end
end
