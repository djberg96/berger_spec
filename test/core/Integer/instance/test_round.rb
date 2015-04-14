#####################################################################
# test_round.rb
#
# Test case for the Integer#round method.
#####################################################################
require 'test/helper'
require 'test/unit'

class TC_Integer_Round_InstanceMethod < Test::Unit::TestCase
  def setup
    @int1 = 65
  end

  test "round basic functionality" do
    assert_respond_to(@int1, :round)
    assert_nothing_raised{ @int1.round }
  end

  test "round on integer with no argument returns expected results" do
    assert_equal(0, 0.round)
    assert_equal(-1, -1.round)
    assert_equal(1, 1.round)
  end

  test "round on integer with positive argument returns expected results" do
    assert_equal(1, 1.round(1))
    assert_equal(1.0, 1.round(2))
    assert_equal(1.00, 1.round(3))
  end

  test "round on integer with negative argument returns expected results" do
    assert_equal(20, 15.round(-1))
    assert_equal(0, 15.round(-2))
    assert_equal(0, 15.round(-3))
  end

  test "round on integer with zero argument returns self" do
    assert_equal(1, 1.round(0))
    assert_equal(15, 15.round(0))
  end

  test "round on float with no argument returns expected results" do
    assert_equal(0, 0.4.round)
    assert_equal(1, 0.5.round)
    assert_equal(-1, -1.1.round)
    assert_equal(1, 1.1.round)
  end

  test "round on float with positive argument returns expected results" do
    assert_equal(1, 1.0.round(1))
    assert_equal(1.0, 1.0.round(2))
    assert_equal(1.00, 1.0.round(3))
  end

  test "round on float with negative argument returns expected results" do
    assert_equal(20, 15.0.round(-1))
    assert_equal(10, 14.9.round(-1))
    assert_equal(0, 14.9.round(-2))
  end

  test "round on float with zero argument returns self" do
    assert_equal(1, 1.0.round(0))
    assert_equal(15, 15.0.round(0))
  end

  test "round only accepts one argument" do
    assert_raise(ArgumentError){ 1.round(1,2) }
  end

  def teardown
    @int1 = nil
  end
end
