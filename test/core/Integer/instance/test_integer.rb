#####################################################################
# test_is_integer.rb
#
# Test case for the Integer#integer? method.
#####################################################################
require 'test/helper'
require 'test/unit'

class TC_Integer_IsInteger_Instance < Test::Unit::TestCase
  def setup
    @int1 = 65
  end

  test "integer? basic functionality" do
    assert_respond_to(@int1, :integer?)
    assert_nothing_raised{ @int1.integer? }
  end

  test "integer? returns true for integer objects" do
    assert_true(@int1.integer?)
    assert_true(-1.integer?)
    assert_true(0.integer?)
  end

  test "integer? returns false for non-integer objects" do
    assert_false(-1.5.integer?)
    assert_false(0.0.integer?)
  end

  test "integer? does not accept any arguments" do
    assert_raises(ArgumentError){ @int1.integer?(2) }
  end

  def teardown
    @int1 = nil
  end
end
