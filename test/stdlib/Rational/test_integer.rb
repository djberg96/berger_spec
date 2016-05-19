######################################################################
# test_integer.rb
#
# Test case for Integer methods defined within rational.rb.
######################################################################
require 'rational'
require 'test/unit'

class TC_Rational_Integer_Stdlib < Test::Unit::TestCase
  def setup
    @int1 = 27
    @int2 = 30
  end

  test "gcd basic functionality" do
    assert_respond_to(@int1, :gcd)
    assert_nothing_raised{ @int1.gcd(@int2) }
  end

  test "gcd returns the expected value" do
    assert_equal(3, @int1.gcd(@int2))
  end

  test "gcd requires a valid argument" do
    assert_raises(ArgumentError){ @int1.gcd }
    assert_raises(TypeError){ @int1.gcd("bogus") }
  end

  test "lcm basic functionality" do
    assert_respond_to(@int1, :lcm)
    assert_nothing_raised{ @int1.lcm(@int2) }
  end

  test "lcm returns the expected value" do
    assert_equal(270, @int1.lcm(@int2))
  end

  test "lcm requires a valid argument" do
    assert_raises(TypeError){ @int1.lcm("bogus") }
    assert_raises(ArgumentError){ @int1.lcm }
  end

  test "gcdlcm basic functionality" do
    assert_respond_to(@int1, :gcdlcm)
    assert_nothing_raised{ @int1.gcdlcm(@int2) }
  end

  test "gcdlcm returns the expected value" do
    assert_equal([3,270], @int1.gcdlcm(@int2))
  end

  test "gcdlcm requires a valid argument" do
    assert_raises(ArgumentError){ @int1.gcdlcm }
    assert_raises(TypeError){ @int1.gcdlcm("bogus") }
  end

  test "numerator basic functionality" do
    assert_respond_to(@int1, :numerator)
    assert_nothing_raised{ @int1.numerator }
  end

  test "numerator returns the expected value" do
    assert_equal(27, @int1.numerator)
  end

  test "denominator basic functionality" do
    assert_respond_to(@int1, :denominator)
    assert_nothing_raised{ @int1.denominator }
  end

  test "denominator returns the expected value" do
    assert_equal(1, @int1.denominator)
  end

  test "to_r basic functionality" do
    assert_respond_to(@int1, :to_r)
    assert_nothing_raised{ @int1.to_r }
  end

  test "to_r returns the expected value" do
    assert_kind_of(Rational, @int1.to_r)
    assert_equal(Rational(27,1), @int1.to_r)
  end

  def teardown
    @int1 = nil
    @int2 = nil
  end
end
